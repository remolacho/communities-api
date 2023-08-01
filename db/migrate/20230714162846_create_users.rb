class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :lastname, null: false
      t.string :token, null: false
      t.string :email, null: false
      t.string :address
      t.string :password_digest, null: false
      t.string :lang, null: false, default: 'es'
      t.string :reset_password_key
      t.datetime :reset_password_key_expires_at
      t.string :active_key
      t.datetime :active_key_expires_at
      t.string :phone
      t.index :identifier, unique: true
      t.index :token, unique: true
      t.index :email, unique: true
      t.index :reset_password_key, unique: true
      t.index :active_key, unique: true
      t.timestamps
    end
  end
end
