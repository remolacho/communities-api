class CreateUserEnterprises < ActiveRecord::Migration[7.0]
  def change
    create_table :user_enterprises do |t|
      t.references :user, null: false
      t.references :enterprise, null: false
      t.boolean :active, default: false
      t.timestamps
    end

    add_index(:user_enterprises, [:user_id, :enterprise_id], unique: true)
  end
end
