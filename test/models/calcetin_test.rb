require 'test_helper'

class CalcetinTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)  # Asegúrate de tener fixtures de usuarios configuradas
    @calcetin = Calcetin.new(
      nombre: "Calcetin de prueba",
      descripcion: "Este es un calcetín de prueba",
      usuario: @user
    )
  end

  test "debería ser válido" do
    assert @calcetin.valid?
  end

  test "nombre no puede estar vacío" do
    @calcetin.nombre = ""
    assert_not @calcetin.valid?
  end

  test "descripcion no puede estar vacía" do
    @calcetin.descripcion = ""
    assert_not @calcetin.valid?
  end

  test "debería pertenecer a un usuario" do
    @calcetin.id_usuario = nil
    assert_not @calcetin.valid?
  end

end
