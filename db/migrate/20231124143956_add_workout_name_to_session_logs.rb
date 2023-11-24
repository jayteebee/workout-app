class AddWorkoutNameToSessionLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :session_logs, :workout_name, :string
  end
end
