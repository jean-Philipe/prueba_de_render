require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
    @match = matches(:one) 
    @chat = Chat.new(sender: @user1, recipient: @user2, match: @match)
  end

  test 'should be valid' do
    assert @chat.valid?
  end

  test 'should require a sender' do
    @chat.sender = nil
    assert_not @chat.valid?
  end

  test 'should require a recipient' do
    @chat.recipient = nil
    assert_not @chat.valid?
  end

  test 'should require a match' do
    @chat.match = nil
    assert_not @chat.valid?
  end

  test 'should belong to sender' do
    assert_equal @user1, @chat.sender
  end

  test 'should belong to recipient' do
    assert_equal @user2, @chat.recipient
  end

  test 'should belong to match' do
    assert_equal @match, @chat.match
  end

  test 'should have many messages' do
    message1 = Message.new(content: 'Hello', user: @user1)
    message2 = Message.new(content: 'Hi', user: @user2)
    @chat.messages << message1
    @chat.messages << message2

    assert_equal [message1, message2], @chat.messages
  end
end
