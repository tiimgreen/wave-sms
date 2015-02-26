class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :user_id
      t.integer :customer_id

      t.timestamps null: false
    end
  end
end
