require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
    @match = Match.new(user_1: @user1, user_2: @user2)
  end

  
  test 'should be valid' do
    assert @match.valid?
  end

  test 'should require user_1' do
    @match.user_1 = nil
    assert_not @match.valid?
  end

  test 'should require user_2' do
    @match.user_2 = nil
    assert_not @match.valid?
  end

  test 'should create a chat after match creation' do

    assert_difference('Chat.count', 1) do
      @match.save
    end

  end

  test 'should have many users through chat' do
    assert @match.users.include?(@user1)
    assert @match.users.include?(@user2)
  end
end
