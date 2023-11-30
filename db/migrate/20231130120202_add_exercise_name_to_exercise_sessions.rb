class AddExerciseNameToExerciseSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :exercise_sessions, :exercise_name, :string
  end
end
