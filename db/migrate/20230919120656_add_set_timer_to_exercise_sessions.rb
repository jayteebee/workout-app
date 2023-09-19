class AddSetTimerToExerciseSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :exercise_sessions, :set_timer, :integer, default: 0, null: false
  end
end
