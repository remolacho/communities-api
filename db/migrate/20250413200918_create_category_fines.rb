class CreateCategoryFines < ActiveRecord::Migration[7.0]
  def change
    create_table :category_fines do |t|
      t.string :name
      t.string :code, index: true, null: false
      t.references :enterprise, null: false, foreign_key: true, index: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }, index: true
      t.boolean :active, null: false, default: true
      t.string :formula
      t.float :value
      t.string :description
      t.bigint :parent_category_fine_id, foreign_key: { to_table: :category_fines }, index: true
      t.timestamps
    end

    add_index :category_fines, [:enterprise_id, :code], unique: true
  end
end
