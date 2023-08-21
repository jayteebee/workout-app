class AddRoutineIdToWorkoutDays < ActiveRecord::Migration[7.0]
  def change
    add_reference :workout_days, :routine, null: false, foreign_key: true, default: 1
  end
end
