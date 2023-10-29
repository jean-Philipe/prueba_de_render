class CalcetinesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @user_calcetines_evaluados = current_user.calcetines_evaluados
    @user_calcetines = Calcetin.where(id_usuario: current_user.id)
    @calcetines_restantes = Calcetin.where.not(id: @user_calcetines_evaluados.pluck(:id))
    @calcetines_restantes = @calcetines_restantes.where.not(id: @user_calcetines.pluck(:id))

    @calcetines = @calcetines_restantes

    # Aplicar los filtros por categoría
    if %w[nuevo casi_nuevo usado].include?(params[:category])
      @calcetines = @calcetines.where(params[:category] => true)
    end

    # Ordenar los calcetines por nombre en orden alfabético ascendente
    @calcetines = @calcetines.order(nombre: :asc) if params[:sort_by] == 'asc'
  end

  def show
    @calcetin = Calcetin.find(params[:id])
  end

  def liked_calcetines
    @calcetines_likes = current_user.calcetines_likes
  end

  def new
    @calcetin = Calcetin.new
  end

  def create
    calcetin_params = params.require(:calcetin).permit(:nombre, :descripcion, :foto, :estado)
  
    # No es necesario mapear el estado ya que se almacena directamente desde el formulario.
  
    if params[:calcetin][:foto].present?
      uploaded_file = params[:calcetin][:foto].tempfile
  
      @cloudinary_response = Cloudinary::Uploader.upload(uploaded_file, resource_type: :auto)
  
      if @cloudinary_response['secure_url'].present?
        calcetin_params[:foto] = @cloudinary_response['secure_url']
      else
        flash[:alert] = 'La carga de la imagen falló.'
        render 'new'
        return
      end
    else
      @cloudinary_response = Cloudinary::Uploader.upload("https://us.123rf.com/450wm/yehorlisnyi/yehorlisnyi2104/yehorlisnyi210400016/167492439-sin-foto-o-icono-de-imagen-en-blanco-cargando-imágenes-o-marca-de-imagen-faltante-imagen-no.jpg")
      calcetin_params[:foto] = @cloudinary_response['secure_url']
    end
  
    @calcetin = Calcetin.new(calcetin_params)
    @calcetin.usuario = current_user
  
    if @calcetin.save
      redirect_to calcetines_path, notice: 'El calcetín se ha creado con éxito.'
    else
      render 'new'
    end
  end
  
  def edit
    @calcetin = Calcetin.find(params[:id])
  end

  def update
    @calcetin = Calcetin.find(params[:id])

    if @calcetin.update(calcetin_params)
      redirect_to calcetines_path, notice: 'El calcetín se ha actualizado con éxito.'
    else
      render 'edit'
    end
  end

  def destroy
    @calcetin = Calcetin.find(params[:id])
    @calcetin.destroy
    redirect_to calcetines_path, notice: 'El calcetín se ha eliminado con éxito.'
  end

  private

  def calcetin_params
    params.require(:calcetin).permit(:nombre, :descripcion, :foto)
  end
end
