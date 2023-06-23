class CreateWorkoutSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.references :routine_workout, null: false, foreign_key: true
      t.datetime :date

      t.timestamps
    end
  end
end
