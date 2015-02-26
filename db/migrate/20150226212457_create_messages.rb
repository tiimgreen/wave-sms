class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.references :sender, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
