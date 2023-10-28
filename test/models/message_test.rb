require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
    @chat = chats(:one)
    @message = Message.new(user: @user1, chat: @chat, content: "Test message")
  end

  test 'should be valid' do
    assert @message.valid?
  end

  test 'should require a user' do
    @message.user = nil
    assert_not @message.valid?
  end

  test 'should require a chat' do
    @message.chat = nil
    assert_not @message.valid?
  end

  test 'should require content' do
    @message.content = "  " 
    assert_not @message.valid?
  end

  test 'should belong to a user' do
    assert_equal @user1, @message.user
  end

  test 'should belong to a chat' do
    assert_equal @chat, @message.chat
  end
end
