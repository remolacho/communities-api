class CreateEnterprises < ActiveRecord::Migration[7.0]
  def change
    create_table :enterprises do |t|
      t.references :tenant
      t.string :token, null: false
      t.string :name, null: false
      t.boolean :active, default: true
      t.index :token, unique: true
      t.timestamps
    end
  end
end
