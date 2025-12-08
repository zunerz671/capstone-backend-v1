class CreateQuestionResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :question_responses do |t|
      t.string :response, null: false
      t.boolean :correct, null: false, default: false
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :assessment_attempt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
