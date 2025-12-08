class CreateAssessmentAttempts < ActiveRecord::Migration[8.0]
  def change
    create_table :assessment_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assessment, null: false, foreign_key: true
      t.integer :score
      t.datetime :completed_at

      t.timestamps
    end
  end
end
