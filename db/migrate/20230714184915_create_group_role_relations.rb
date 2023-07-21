class CreateGroupRoleRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :group_role_relations do |t|
      t.references :group_role, null: false
      t.references :role, null: false
      t.timestamps
    end

    add_index(:group_role_relations, [:group_role_id, :role_id], unique: true)
  end
end
