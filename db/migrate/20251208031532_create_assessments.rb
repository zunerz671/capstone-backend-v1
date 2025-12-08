class CreateAssessments < ActiveRecord::Migration[8.0]
  def change
    create_table :assessments do |t|
      t.string :title, null: false
      t.integer :version, null: false, default: 1
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
