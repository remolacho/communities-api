class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :currency_code, null: false
      t.string :currency_symbol, null: false
      t.boolean :active, default: true

      t.index :code, unique: true
      t.index :name, unique: true

      t.timestamps
    end
  end
end
