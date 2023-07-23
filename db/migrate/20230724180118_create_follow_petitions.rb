class CreateFollowPetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_petitions do |t|
      t.references :user
      t.references :petition
      t.references :status
      t.string :observation
      t.timestamps
    end
  end
end
