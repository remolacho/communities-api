class CreatePropertyAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :property_attributes do |t|
      t.references :property
      t.string  :token, null: false
      t.jsonb   :name, null: false, default: {}
      t.jsonb   :name_as, default: {}
      t.integer :min_range, default: 1
      t.integer :max_range, default: 1
      t.string  :prefix
      t.string  :input, null: false, default: 'list'
      t.integer :created_by, null: false
      t.integer :updated_by, null: false
      t.timestamps
      t.index :token, unique: true
    end
  end
end
