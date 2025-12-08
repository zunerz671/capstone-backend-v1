# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_12_08_031605) do
  create_table "assessment_attempts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "assessment_id", null: false
    t.integer "score"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_assessment_attempts_on_assessment_id"
    t.index ["user_id"], name: "index_assessment_attempts_on_user_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.string "title", null: false
    t.integer "version", default: 1, null: false
    t.integer "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_assessments_on_lesson_id"
  end

  create_table "lesson_pages", force: :cascade do |t|
    t.integer "lesson_id", null: false
    t.string "title"
    t.string "image_url", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_lesson_pages_on_lesson_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_responses", force: :cascade do |t|
    t.string "response", null: false
    t.boolean "correct", default: false, null: false
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.integer "assessment_attempt_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_attempt_id"], name: "index_question_responses_on_assessment_attempt_id"
    t.index ["question_id"], name: "index_question_responses_on_question_id"
    t.index ["user_id"], name: "index_question_responses_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.string "image_url", null: false
    t.string "correct_answer", null: false
    t.integer "assessment_id", null: false
    t.integer "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_questions_on_assessment_id"
    t.index ["lesson_id"], name: "index_questions_on_lesson_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "role", default: "student", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "assessment_attempts", "assessments"
  add_foreign_key "assessment_attempts", "users"
  add_foreign_key "assessments", "lessons"
  add_foreign_key "lesson_pages", "lessons"
  add_foreign_key "question_responses", "assessment_attempts"
  add_foreign_key "question_responses", "questions"
  add_foreign_key "question_responses", "users"
  add_foreign_key "questions", "assessments"
  add_foreign_key "questions", "lessons"
end
