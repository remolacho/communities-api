class CreateGroupRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :group_roles do |t|
      t.string :code, null: false
      t.jsonb :name, null: false, default: {}
      t.boolean :active, default: true
      t.index :code, unique: true
      t.timestamps
    end
  end
end
