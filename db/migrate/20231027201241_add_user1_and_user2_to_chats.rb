class AddUser1AndUser2ToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :user_1_id, :integer
    add_column :chats, :user_2_id, :integer
  end
end
