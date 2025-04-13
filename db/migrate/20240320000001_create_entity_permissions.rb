class CreateEntityPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :entity_permissions do |t|
      t.references :role, null: false, foreign_key: true
      t.string :entity_type, null: false

      t.boolean :can_read, default: false
      t.boolean :can_write, default: false
      t.boolean :can_destroy, default: false
      t.boolean :can_change_status, default: false
      t.jsonb :custom_permissions, default: {}

      t.timestamps
    end

    add_index :entity_permissions, [:role_id, :entity_type], unique: true
  end
end
