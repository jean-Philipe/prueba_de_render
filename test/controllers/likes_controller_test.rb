require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Para autenticación de usuarios

  def setup
    @user = users(:one) # Cambia esto por tu modelo de usuario
    @calcetin = calcetins(:one) # Cambia esto por tu modelo de calcetín
  end

  test "should create like" do
    sign_in @user
    assert_difference('Like.count', 1) do
      post likes_path(id: @calcetin.id, liked: true)
    end
    assert_redirected_to likes_path
    assert_equal "Has evaluado al calcetín.", flash[:success]
  end



end
