class AddPermalinkToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :permalink, :string
  end
end
