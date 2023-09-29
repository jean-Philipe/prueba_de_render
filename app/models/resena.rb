# app/models/review.rb
class Resena < ApplicationRecord
  belongs_to :user # Una reseña pertenece a un usuario

  validates :puntuacion, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comentario, presence: true, length: { minimum: 5, maximum: 1000 }
end

