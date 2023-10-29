class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #puede dar muchos likes y puede tener muchos calcetines publicados
  has_many :likes, foreign_key: 'id_usuario_like', dependent: :destroy
  has_many :calcetines_likes, through: :likes, source: :calcetin

  #cada usuario tiene una lista de calcetines que ya evaluo (puede ser like o no like)
  has_many :calcetines_evaluados, through: :likes, source: :calcetin
  has_many :calcetines_liked, -> { where(likes: { liked: true }) }, through: :likes, source: :calcetin
  has_many :resenas, dependent: :destroy

  has_many :matches_as_user1, class_name: 'Match', foreign_key: 'user_1_id'
  has_many :matches_as_user2, class_name: 'Match', foreign_key: 'user_2_id'
  attribute :admin, :boolean
  
  def matches
    (matches_as_user1 + matches_as_user2).uniq
  end

  has_many :chats, through: :matches_as_user1, source: :chat

  has_one_attached :profile_picture
  has_many :calcetines_publicados, foreign_key: 'usuario_id', dependent: :destroy

  def admin?
    admin # Devuelve el valor del atributo admin
  end
end
