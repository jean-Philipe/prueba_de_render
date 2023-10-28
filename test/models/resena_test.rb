require 'test_helper'

class ResenaTest < ActiveSupport::TestCase
  def setup
    @user = users(:one) 
    @resena = Resena.new(user: @user, puntuacion: 5, comentario: "Una reseña válida")
  end

  test 'should be valid' do
    assert @resena.valid?
  end

  test 'should require a user' do
    @resena.user = nil
    assert_not @resena.valid?
  end

  test 'should require a puntuacion between 1 and 5' do
    @resena.puntuacion = 0
    assert_not @resena.valid?
    @resena.puntuacion = 6
    assert_not @resena.valid?
  end

  test 'should require a comentario with a minimum length of 5' do
    resena = Resena.new(user: users(:one), puntuacion: 4, comentario: '1234') # Comentario con longitud menor a 5
    assert_not resena.valid?
  end  

  test 'should require a comentario with a maximum length of 1000' do
    @resena.comentario = 'a' * 1001
    assert_not @resena.valid?
  end
end
