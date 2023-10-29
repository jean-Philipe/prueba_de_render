require 'test_helper'

class CalcetinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calcetin = calcetins(:one)  
    @user = users(:one)  
  end

  test "should get index" do
    get calcetins_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user  # Simula iniciar sesión para crear calcetins
    get new_calcetin_url
    assert_response :success
  end

  test "should create calcetin" do
    sign_in @user
    assert_difference('Calcetin.count') do
      post calcetins_url, params: { calcetin: { nombre: @calcetin.nombre, descripcion: @calcetin.descripcion, estado: @calcetin.estado, foto: @calcetin.foto } }
    end

    assert_redirected_to calcetin_url(Calcetin.last)
  end

  test "should show calcetin" do
    get calcetin_url(@calcetin)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_calcetin_url(@calcetin)
    assert_response :success
  end

  test "should update calcetin" do
    sign_in @user
    patch calcetin_url(@calcetin), params: { calcetin: { nombre: @calcetin.nombre, descripcion: @calcetin.descripcion, estado: @calcetin.estado, foto: @calcetin.foto } }
    assert_redirected_to calcetin_url(@calcetin)
  end

  test "should destroy calcetin" do
    sign_in @user
    assert_difference('Calcetin.count', -1) do
      delete calcetin_url(@calcetin)
    end

    assert_redirected_to calcetins_url
  end
end
