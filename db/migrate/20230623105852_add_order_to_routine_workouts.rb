class AddOrderToRoutineWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :routine_workouts, :order, :integer
  end
end
