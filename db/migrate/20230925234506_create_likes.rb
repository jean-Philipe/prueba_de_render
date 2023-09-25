class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :id_calcetin
      t.integer :id_usuario_like
      t.integer :id_usuario_calcetin

      t.timestamps
    end
  end
end
