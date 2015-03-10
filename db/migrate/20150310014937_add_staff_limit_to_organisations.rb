class AddStaffLimitToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :staff_limit, :integer
  end
end
