class AddOrganisationIdRemoveUserIdFromChats < ActiveRecord::Migration
  def change
    add_column :chats, :organisation_id, :integer
    remove_column :chats, :user_id
  end
end
