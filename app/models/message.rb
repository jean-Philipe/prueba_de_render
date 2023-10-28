class Message < ApplicationRecord
    belongs_to :user
    belongs_to :chat, class_name: "Chat", foreign_key: "chat_id"
end
