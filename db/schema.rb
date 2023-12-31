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

ActiveRecord::Schema[7.0].define(version: 2023_12_28_112843) do
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
    t.integer "set_timer", default: 0, null: false
    t.string "exercise_name"
    t.index ["exercise_id"], name: "index_exercise_sessions_on_exercise_id"
    t.index ["workout_session_id"], name: "index_exercise_sessions_on_workout_session_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.integer "personal_best"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "equipment_used"
    t.string "primary_muscles", default: [], array: true
    t.string "secondary_muscles", default: [], array: true
  end

  create_table "routine_workouts", force: :cascade do |t|
    t.bigint "routine_id", null: false
    t.bigint "workout_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.string "day", default: [], array: true
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

  create_table "session_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.jsonb "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workout_name"
    t.index ["user_id"], name: "index_session_logs_on_user_id"
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
    t.string "jti", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_days", force: :cascade do |t|
    t.integer "days_of_week", default: [], array: true
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "routine_id", default: 1, null: false
    t.integer "frequency"
    t.index ["routine_id"], name: "index_workout_days_on_routine_id"
    t.index ["user_id"], name: "index_workout_days_on_user_id"
  end

  create_table "workout_exercises", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sets"
    t.integer "reps"
    t.float "weight"
    t.integer "rest_timer"
    t.index ["exercise_id"], name: "index_workout_exercises_on_exercise_id"
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workout_schedules", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "routine_workout_id", null: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false
    t.index ["routine_workout_id"], name: "index_workout_schedules_on_routine_workout_id"
    t.index ["user_id"], name: "index_workout_schedules_on_user_id"
  end

  create_table "workout_sessions", force: :cascade do |t|
    t.bigint "routine_workout_id", null: false
    t.bigint "user_id", null: false
    t.datetime "date"
    t.integer "total_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workout_name"
    t.index ["routine_workout_id"], name: "index_workout_sessions_on_routine_workout_id"
    t.index ["user_id"], name: "index_workout_sessions_on_user_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
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
  add_foreign_key "session_logs", "users"
  add_foreign_key "workout_days", "routines"
  add_foreign_key "workout_days", "users"
  add_foreign_key "workout_exercises", "exercises"
  add_foreign_key "workout_exercises", "workouts"
  add_foreign_key "workout_schedules", "routine_workouts"
  add_foreign_key "workout_schedules", "users"
  add_foreign_key "workout_sessions", "users"
  add_foreign_key "workout_sessions", "workouts", column: "routine_workout_id"
  add_foreign_key "workouts", "users"
end
