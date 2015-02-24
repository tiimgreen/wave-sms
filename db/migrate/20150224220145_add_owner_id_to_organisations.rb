class AddOwnerIdToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :owner_id, :integer
  end
end
