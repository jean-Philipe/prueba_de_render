class Match < ApplicationRecord
  belongs_to :user_1, class_name: "User", foreign_key: "user_1_id"
  belongs_to :user_2, class_name: "User", foreign_key: "user_2_id"

  has_one :chat
  
  after_create :create_chat

  private

  def create_chat
    Chat.create(match: self)
  end

end
