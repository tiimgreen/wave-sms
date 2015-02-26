class AddTimeFieldsToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :time_of_closing, :datetime
    add_column :customers, :time_of_assignment, :datetime
  end
end
