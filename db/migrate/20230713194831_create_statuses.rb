class CreateStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :statuses do |t|
      t.jsonb :name, null: false
      t.string :code, null: false
      t.string :status_type, null: false
      t.index :code, unique: true
      t.timestamps
    end
  end
end
