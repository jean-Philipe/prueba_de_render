require "test_helper"

class MainViewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get main_view_index_url
    assert_response :success
  end
end
