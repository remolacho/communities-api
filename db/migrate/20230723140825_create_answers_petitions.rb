class CreateAnswersPetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :answers_petitions do |t|
      t.references :petition, null: false
      t.references :user, null: false
      t.string :message, null: false
      t.timestamps
    end
  end
end
