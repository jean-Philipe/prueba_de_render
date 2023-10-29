class Calcetin < ApplicationRecord
  # Necesita subir foto y pertenece a un usuario
  belongs_to :usuario, class_name: 'User', foreign_key: 'id_usuario'
  has_many :usuarios_evaluaron, through: :likes, source: :user

  validates :nombre, presence: true
  validates :descripcion, presence: true
  validates :estado, presence: true

  # Resto de las validaciones y relaciones aquí
end
