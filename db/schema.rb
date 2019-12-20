# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_20_133039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "answer_possibilities", force: :cascade do |t|
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "answer_possibilities_questions", id: false, force: :cascade do |t|
    t.bigint "answer_possibility_id", null: false
    t.bigint "question_id", null: false
  end

  create_table "answer_possibility_translations", force: :cascade do |t|
    t.bigint "answer_possibility_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.index ["answer_possibility_id"], name: "index_answer_possibility_translations_on_answer_possibility_id"
    t.index ["locale"], name: "index_answer_possibility_translations_on_locale"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "answer_possibility_id"
    t.bigint "survey_entry_id"
    t.bigint "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_possibility_id"], name: "index_answers_on_answer_possibility_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["survey_entry_id"], name: "index_answers_on_survey_entry_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "question_group_translations", force: :cascade do |t|
    t.bigint "question_group_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.index ["locale"], name: "index_question_group_translations_on_locale"
    t.index ["question_group_id"], name: "index_question_group_translations_on_question_group_id"
  end

  create_table "question_groups", force: :cascade do |t|
    t.bigint "survey_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_question_groups_on_survey_id"
  end

  create_table "question_translations", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.index ["locale"], name: "index_question_translations_on_locale"
    t.index ["question_id"], name: "index_question_translations_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "question_group_id"
    t.bigint "answer_possibilities_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_possibilities_id"], name: "index_questions_on_answer_possibilities_id"
    t.index ["question_group_id"], name: "index_questions_on_question_group_id"
  end

  create_table "survey_entries", force: :cascade do |t|
    t.bigint "survey_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_survey_entries_on_survey_id"
  end

  create_table "survey_translations", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.index ["locale"], name: "index_survey_translations_on_locale"
    t.index ["survey_id"], name: "index_survey_translations_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "active_from"
    t.datetime "active_to"
  end

end
