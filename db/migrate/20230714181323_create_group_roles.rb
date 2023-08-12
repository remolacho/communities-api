class CreateGroupRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :group_roles do |t|
      t.string :code, null: false
      t.jsonb :name, null: false, default: {}
      t.string :entity_type, null: false, default: 'petitions'
      t.boolean :active, default: true
      t.timestamps
    end

    add_index(:group_roles, [:code, :entity_type], unique: true)
  end
end
