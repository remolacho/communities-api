class CreateTenants < ActiveRecord::Migration[7.0]
  def change
    create_table :tenants do |t|
      t.string :subdomain
      t.string :token, null: false
      t.boolean :active, default: true
      t.index :subdomain, unique: true
      t.index :token, unique: true
      t.timestamps
    end
  end
end
