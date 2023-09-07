class AddFrequencyColumnToWorkoutDays < ActiveRecord::Migration[7.0]
  def change
    add_column :workout_days, :frequency, :integer
  end
end
