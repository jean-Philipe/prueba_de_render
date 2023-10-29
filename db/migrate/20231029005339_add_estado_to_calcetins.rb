class AddEstadoToCalcetins < ActiveRecord::Migration[7.0]
  def change
    add_column :calcetins, :estado, :string
  end
end
