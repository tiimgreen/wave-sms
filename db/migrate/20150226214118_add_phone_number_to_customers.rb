class AddPhoneNumberToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :phone_number, :string
  end
end
