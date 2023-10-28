class Chat < ApplicationRecord
    belongs_to :sender, class_name: 'User', foreign_key: 'user_1_id'
    belongs_to :recipient, class_name: 'User', foreign_key: 'user_2_id'
    belongs_to :match
  
    has_many :messages, foreign_key: 'chat_id', dependent: :destroy
  
    has_many :users, through: :match, source: :user_1 # Reemplaza 'source' con el nombre correcto
  end
  