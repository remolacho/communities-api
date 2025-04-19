class CreateFines < ActiveRecord::Migration[7.0]
  def change
    create_table :fines do |t|
      t.references :status, null: false, index: true
      t.references :user, null: false, index: true
      t.references :property, null: false, index: true
      t.references :category_fine, null: false, index: true
      t.string :token, null: false
      t.string :ticket, null: false
      t.string :title, null: false
      t.string :message, null: false
      t.string :fine_type, null: false
      t.float :value, default: 0
      t.index :token, unique: true
      t.index :ticket, unique: true
      t.timestamps
    end
  end
end
