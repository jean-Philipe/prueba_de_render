class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #puede dar muchos likes y puede tener muchos calcetines publicados
  has_many :likes, foreign_key: "id_usuario_like", dependent: :destroy
  has_many :calcetines, dependent: :destroy

  #cada usuario tiene una lista de calcetines que ya evaluo (puede ser like o no like)
  has_many :calcetines_evaluados, through: :likes, source: :calcetin
  has_many :calcetines_likes, -> { where(liked: true) }, through: :likes, source: :calcetin



end
