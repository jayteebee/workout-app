class AddCompletedToWorkoutSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :workout_schedules, :completed, :boolean, default: false
  end
end
