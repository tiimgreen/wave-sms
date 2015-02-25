class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :staff_id
      t.integer :organisation_id
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :city
      t.string :postal_code
      t.string :country
      t.boolean :wants_promotions, default: false

      t.timestamps null: false
    end
  end
end
