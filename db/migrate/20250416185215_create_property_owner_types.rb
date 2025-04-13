class CreatePropertyOwnerTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :property_owner_types do |t|
      t.references :enterprise, null: false, foreign_key: true, index: true
      t.string :code, null: false, index: { unique: true }
      t.string :name, null: false
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
