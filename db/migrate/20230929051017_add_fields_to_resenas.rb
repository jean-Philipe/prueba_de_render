# db/migrate/xxxxxx_add_fields_to_resenas.rb
class AddFieldsToResenas < ActiveRecord::Migration[6.0]
  def change
    add_column :resenas, :puntuacion, :integer
    add_column :resenas, :comentario, :text

    # Asegúrate de que estás creando la referencia a :user en lugar de :author
  end
end
