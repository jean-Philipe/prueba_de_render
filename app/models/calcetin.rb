class Calcetin < ApplicationRecord

    #necesita subir foto y pertenece a un usuario

    belongs_to :usuario, class_name: 'User', foreign_key: 'id_usuario'
    has_many :usuarios_evaluaron, through: :likes, source: :user


    validates :nombre, presence: true
    validates :descripcion, presence: true

    attr_accessor :foto

end
