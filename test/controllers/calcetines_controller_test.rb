require 'test_helper'

class CalcetinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calcetin = calcetins(:one)
    @user = users(:one)
    sign_in @user # Inicia sesión con el usuario antes de ejecutar las pruebas
  end

  test "should get index" do
    get calcetines_path
    assert_response :success
  end

  test "should get new" do
    sign_in @user  # Simula iniciar sesión para crear calcetines
    get new_calcetin_path
    assert_response :success
  end

  test "should create calcetin" do
    sign_in @user
    assert_difference('Calcetin.count') do
      image_file = fixture_file_upload(Rails.root.join('test', 'fixtures', 'files', 'your_image.jpg'), 'image/jpeg') 
      post calcetines_url, params: { calcetin: { nombre: @calcetin.nombre, descripcion: @calcetin.descripcion, estado: @calcetin.estado, foto: image_file } }
    end
  
    assert_redirected_to calcetin_url(Calcetin.last)
  end  

  test "should get edit" do
    sign_in @user
    get edit_calcetine_path(@calcetin)
    assert_response :success
  end

  test "should update calcetin" do
    sign_in @user
    patch update_calcetin_path(@calcetin), params: { calcetin: { nombre: @calcetin.nombre, descripcion: @calcetin.descripcion, estado: @calcetin.estado, foto: @calcetin.foto } }
    assert_redirected_to calcetines_path(@calcetin)
  end

end
