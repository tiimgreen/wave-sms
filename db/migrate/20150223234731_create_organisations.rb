class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :phone_number
      t.string :area_code

      t.timestamps null: false
    end
  end
end
