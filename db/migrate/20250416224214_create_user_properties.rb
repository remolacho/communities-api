class CreateUserProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :user_properties do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :property, null: false, foreign_key: true, index: true
      t.references :property_owner_type, null: false, foreign_key: true, index: true
      t.boolean :active, null: false, default: true
      t.timestamps
    end

    add_index :user_properties, [:user_id, :property_id], unique: true
  end
end
