class Like < ApplicationRecord

    #relacion de pertencia entre el like y el usuario que lo da y el calcetín al que se lo da

  belongs_to :liker, class_name: "User", foreign_key: "id_usuario_like"
  belongs_to :calcetin, foreign_key: "id_calcetin" #con calcetin.id_user podemos sacar el usuario likeado

    #se valida que el usuario solo pueda dar un like a cada celcetín y no multiples likes. 
  validates :id_usuario_like, uniqueness: { scope: :id_calcetin }
end
