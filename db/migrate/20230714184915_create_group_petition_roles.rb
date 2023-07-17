class CreateGroupPetitionRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :group_petition_roles do |t|
      t.references :group_petition, null: false
      t.references :role, null: false
      t.boolean :active, default: true
      t.timestamps
    end

    add_index(:group_petition_roles, [:group_petition_id, :role_id], unique: true)
  end
end
