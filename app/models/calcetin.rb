class Calcetin < ApplicationRecord

    #necesita subir foto y pertenece a un usuario
    has_one_attached :foto
    belongs_to :user
    has_many :usuarios_evaluaron, through: :likes, source: :user


    validates :nombre, presence: true
    validates :descripcion, presence: true

end
