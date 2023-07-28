class CreatePetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :petitions do |t|
      t.string :token, null: false
      t.string :ticket, null: false
      t.string :title, null: false
      t.string :message, null: false
      t.references :status, null: false
      t.references :user, null: false
      t.references :category_petition, null: false
      t.references :group_role, null: false
      t.index :token, unique: true
      t.index :ticket, unique: true
      t.timestamps
    end
  end
end
