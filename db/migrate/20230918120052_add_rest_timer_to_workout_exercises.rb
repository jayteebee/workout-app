class AddRestTimerToWorkoutExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :workout_exercises, :rest_timer, :integer
  end
end
