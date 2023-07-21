class CreateEnterprises < ActiveRecord::Migration[7.0]
  def change
    create_table :enterprises do |t|
      t.string :rut, null: false
      t.string :token, null: false
      t.string :subdomain, null: false
      t.string :name, null: false
      t.string :short_name, null: false
      t.string :address
      t.boolean :active, default: true
      t.index :token, unique: true
      t.index :subdomain, unique: true
      t.index :rut, unique: true
      t.timestamps
    end
  end
end
