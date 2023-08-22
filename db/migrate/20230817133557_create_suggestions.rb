class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.string :token, null: false
      t.string :ticket, null: false
      t.string :message, null: false
      t.boolean :readed, default: false
      t.boolean :anonymous, default: false
      t.references :user, null: false
      t.index :token, unique: true
      t.index :ticket, unique: true
      t.timestamps
    end
  end
end
