require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)  # Asegúrate de que tengas usuarios de muestra en tu base de datos
    @user2 = users(:two)
    @match = matches(:one)  # Asegúrate de que tengas matches de muestra en tu base de datos
  end
  
  test "should get index" do
    sign_in @user1

    get matches_path

    assert_response :success
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:matches)
    assert_template 'index'

    @matches = assigns(:matches)
    assert_not_nil @matches

    @matches.each do |match|
      assert_select 'p', text: "ACA HAY UN MATCH #{match.id}"
      assert_select 'p', text: "ID USER 1 #{match.user_1_id}"
      assert_select 'p', text: "IS USER 2 #{match.user_2_id}"
    end

    @other_user_ids = []

    @matches.each do |match|
      if match.user_1_id == @user1.id
        @other_user_ids << match.user_2_id
      else
        @other_user_ids << match.user_1_id
      end
    end

    @usuarios_matches = User.where(id: @other_user_ids)
    assert_not_nil @usuarios_matches
  end
end
