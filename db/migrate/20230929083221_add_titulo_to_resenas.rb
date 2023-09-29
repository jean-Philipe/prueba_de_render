class AddTituloToResenas < ActiveRecord::Migration[7.0]
  def change
    add_column :resenas, :titulo, :string
  end
end
