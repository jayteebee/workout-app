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

ActiveRecord::Schema[7.0].define(version: 2023_06_19_154228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_sessions", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.bigint "workout_session_id", null: false
    t.integer "sets_completed"
    t.integer "reps_completed"
    t.integer "weight_used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_sessions_on_exercise_id"
    t.index ["workout_session_id"], name: "index_exercise_sessions_on_workout_session_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "sets"
    t.integer "reps"
    t.float "weight"
    t.integer "duration"
    t.integer "personal_best"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routine_workouts", force: :cascade do |t|
    t.bigint "routine_id", null: false
    t.bigint "workout_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["routine_id"], name: "index_routine_workouts_on_routine_id"
    t.index ["workout_id"], name: "index_routine_workouts_on_workout_id"
  end

  create_table "routines", force: :cascade do |t|
    t.string "name"
    t.integer "frequency"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_routines_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "height"
    t.integer "weight"
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_exercises", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_workout_exercises_on_exercise_id"
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workout_sessions", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "user_id", null: false
    t.datetime "date"
    t.integer "total_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workout_sessions_on_user_id"
    t.index ["workout_id"], name: "index_workout_sessions_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.datetime "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "exercise_sessions", "exercises"
  add_foreign_key "exercise_sessions", "workout_sessions"
  add_foreign_key "routine_workouts", "routines"
  add_foreign_key "routine_workouts", "workouts"
  add_foreign_key "routines", "users"
  add_foreign_key "workout_exercises", "exercises"
  add_foreign_key "workout_exercises", "workouts"
  add_foreign_key "workout_sessions", "users"
  add_foreign_key "workout_sessions", "workouts"
  add_foreign_key "workouts", "users"
end
