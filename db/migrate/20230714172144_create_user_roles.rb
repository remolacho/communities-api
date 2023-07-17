class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.references :user, null: false
      t.references :role, null: false
      t.boolean :active, default: true
      t.timestamps
    end

    add_index(:user_roles, [:user_id, :role_id], unique: true)
  end
end
