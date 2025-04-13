class CreateUserProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :user_properties do |t|
      t.references :property
      t.references :user
      t.references :status
      t.string  :observation, null: false
      t.jsonb   :property_attributes, null: false, default: {}
      t.timestamps
    end
  end
end
