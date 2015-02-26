class AddChatIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :chat_id, :integer
  end
end
