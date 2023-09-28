class RemoveIdUsuarioCalcetinFromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :id_usuario_calcetin, :integer
  end
end
