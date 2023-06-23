class CreateWorkoutDays < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_days do |t|
      t.integer :days_of_week, array: true, default: []
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
