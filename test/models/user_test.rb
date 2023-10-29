require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'should require an email' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'should have many likes' do
    assert_not @user.likes.empty?
  end

  test 'should have many calcetines_likes through likes' do
    assert_not @user.calcetines_likes.empty?
  end

  test 'should have many calcetines_evaluados through likes' do
    assert_not @user.calcetines_evaluados.empty?
  end

  test 'should have many resenas' do
    assert_not @user.resenas.empty?
  end

  test 'should have many matches' do
    assert_not @user.matches.empty?
  end

  test 'should have many chats through matches' do
    assert_not @user.chats.empty?
  end
end
