class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :lastname, null: false
      t.string :token, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :lang, null: false, default: 'es'
      t.string :phone
      t.index :identifier, unique: true
      t.index :token, unique: true
      t.index :email, unique: true
      t.timestamps
    end
  end
end
