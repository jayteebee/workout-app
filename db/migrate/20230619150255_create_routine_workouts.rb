class CreateRoutineWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :routine_workouts do |t|
      t.references :routine, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true

      t.timestamps
    end
  end
end
