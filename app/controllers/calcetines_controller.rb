class CalcetinesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @calcetines = Calcetin.all
      @user_calcetines_evaluados = current_user.calcetines_evaluados
      @user_calcetines = @calcetines.select { |calcetin| calcetin.id_usuario == current_user.id }
      @calcetines_restantes = @calcetines - @user_calcetines_evaluados - @user_calcetines

  end
  
  def show
    @calcetin = calcetin.find(params[:id])
  end

  def liked_calcetines
    @calcetines_likes = current_user.calcetines_likes # Obtener los calcetines "liked" por el usuario
  end
  
  def new
    @calcetin = Calcetin.new
  end
    
  def create
    calcetin_params = params.require(:calcetin).permit(:nombre, :descripcion, :foto)

    if params[:calcetin][:foto].present?
      uploaded_file = params[:calcetin][:foto].tempfile
      
      @cloudinary_response = Cloudinary::Uploader.upload(uploaded_file, resource_type: :auto)

      puts "esperando respuesta"

      if @cloudinary_response['secure_url'].present?
        # Si @cloudinary_response['secure_url'] está presente, significa que la carga fue exitosa.
        # Puedes imprimirlo para verificar.
        puts "URL segura de la imagen: #{@cloudinary_response['secure_url']}"
      else
        # Si @cloudinary_response['secure_url'] está en blanco, puede indicar un problema en la carga.
        # Puedes imprimir un mensaje de error o realizar otras acciones de manejo de errores aquí.
        puts "La carga de la imagen falló."
      end


      calcetin_params[:foto] = @cloudinary_response['secure_url'] 

      puts calcetin_params

      @calcetin = Calcetin.new(calcetin_params)
  
      @calcetin.usuario = current_user

  
      @calcetin.foto = @cloudinary_response['secure_url']
      puts "URL de la foto en @calcetin.foto: #{@calcetin.foto}"
    
    
    
    else

      @cloudinary_response = Cloudinary::Uploader.upload("https://us.123rf.com/450wm/yehorlisnyi/yehorlisnyi2104/yehorlisnyi210400016/167492439-sin-foto-o-icono-de-imagen-en-blanco-cargando-im%C3%A1genes-o-marca-de-imagen-faltante-imagen-no.jpg")
      calcetin_params[:foto] = @cloudinary_response['secure_url'] 

      @calcetin = Calcetin.new(calcetin_params)
  
      @calcetin.usuario = current_user
  
      @calcetin.foto = @cloudinary_response['secure_url']

    end


    if @calcetin.save
      redirect_to calcetines_path, notice: 'El calcetín se ha creado con éxito.'
    else
      puts @calcetin.errors.full_messages
      render 'new'
    end
  end
    
  
  def edit #se abre el formulario para editar pero aun no se edita
    @calcetin = Calcetin.find(params[:id])
  end
  
  def update #ahora si se edita y actualiza
    @calcetin = Calcetin.find(params[:id])

    puts "los nuevos datos son:"

    puts calcetin_params

    if @calcetin.update(calcetin_params)
      redirect_to calcetines_path, notice: 'El calcetín se ha actualizado con éxito.'
      #Esta opción redirigirá al usuario a la página de visualización del calcetín recién creado.

    else
      render 'edit' #si ocurre un error se vuelbe a edit 
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
  