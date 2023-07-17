class CreateCategoryPetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :category_petitions do |t|
      t.references :enterprise, null: false
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :parent_category_id
      t.index :slug, unique: true
      t.index :parent_category_id
      t.timestamps
    end
  end
end
