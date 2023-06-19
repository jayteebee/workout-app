class RemoveColumnsFromWorkouts < ActiveRecord::Migration[7.0]
  def change
    remove_column :workouts, :duration, :integer
    remove_column :workouts, :date, :datetime
  end
end
