require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  
end