class CreateResenas < ActiveRecord::Migration[7.0]
  def change
    create_table :resenas do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.integer :puntuacion
      t.text :comentario

      t.timestamps
    end
  end
end
