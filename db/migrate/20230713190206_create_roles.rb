class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.jsonb :name, null: false
      t.string :code, null: false
      t.string :slug, null: false
      t.index :code, unique: true
      t.index :slug, unique: true
      t.timestamps
    end
  end
end
