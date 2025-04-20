class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.references :enterprise, null: false, foreign_key: true, index: true
      t.references :property_type, null: false, foreign_key: true, index: true
      t.references :status, null: false, foreign_key: true, index: true
      t.string :location, null: false
      t.boolean :active, null: false, default: true
      t.timestamps
    end

    add_index :properties, [:property_type_id, :location], unique: true
  end
end
