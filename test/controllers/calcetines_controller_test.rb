require 'test_helper'

class CalcetinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calcetin = calcetins(:one)  # Ensure you have sample calcetins in your database
    @user = users(:one)  # Ensure you have sample users in your database
  end

  test "should get index" do
    get calcetines_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user  # Simulate signing in a user
    get new_calcetin_url
    assert_response :success
  end

  test "should create calcetin" do
    sign_in @user
    assert_difference('Calcetin.count') do
      post calcetines_url, params: { calcetin: { nombre: @calcetin.nombre, descripcion: @calcetin.descripcion, estado: @calcetin.estado, foto: @calcetin.foto } }
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
    patch update_calcetin_url(@calcetin), params: { calcetin: { nombre: @calcetin.nombre, descripcion: @calcetin.descripcion, estado: @calcetin.estado, foto: @calcetin.foto } }
    assert_redirected_to calcetin_url(@calcetin)
  end

  test "should destroy calcetin" do
    sign_in @user
    assert_difference('Calcetin.count', -1) do
      delete destroy_calcetin_url(@calcetin)
    end

    assert_redirected_to calcetines_url
  end


  
end
