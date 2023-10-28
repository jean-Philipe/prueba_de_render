class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.text :mensaje
      t.integer :match_id

      t.timestamps
    end
  end
end
