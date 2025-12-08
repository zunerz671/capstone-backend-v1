class CreateLessonPages < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_pages do |t|
      t.references :lesson, null: false, foreign_key: true
      t.string :title
      t.string :image_url, null: false
      t.integer :position

      t.timestamps
    end
  end
end
