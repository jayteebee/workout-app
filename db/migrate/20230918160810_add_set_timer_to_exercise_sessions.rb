class AddSetTimerToExerciseSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :exercise_sessions, :set_timer, :integer, array: true, default: []
  end
end

