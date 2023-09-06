class AddDayToRoutineWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :routine_workouts, :day, :string, array: true, default: []
  end
end
