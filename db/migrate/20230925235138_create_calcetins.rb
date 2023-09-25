class CreateCalcetins < ActiveRecord::Migration[7.0]
  def change
    create_table :calcetins do |t|
      t.integer :id_usuario
      t.string :nombre
      t.text :descripcion
      t.string :foto
      t.boolean :disponibilidad

      t.timestamps
    end
  end
end
