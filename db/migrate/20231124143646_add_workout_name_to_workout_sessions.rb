class AddWorkoutNameToWorkoutSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :workout_sessions, :workout_name, :string
  end
end
