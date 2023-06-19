class CreateExerciseSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_sessions do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :workout_session, null: false, foreign_key: true
      t.integer :sets_completed
      t.integer :reps_completed
      t.integer :weight_used

      t.timestamps
    end
  end
end
