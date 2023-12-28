class RemoveSetTimerFromExerciseSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column :exercise_sessions, :set_timer if column_exists? :exercise_sessions, :set_timer
  end
end