class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.jsonb  :name, null: false
      t.string :token, null: false
      t.timestamps
      t.index :token, unique: true
    end
  end
end
