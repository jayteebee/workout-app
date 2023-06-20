class AddSetsRepsWeightToWorkoutExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :workout_exercises, :sets, :integer
    add_column :workout_exercises, :reps, :integer
    add_column :workout_exercises, :weight, :float
  end
end
