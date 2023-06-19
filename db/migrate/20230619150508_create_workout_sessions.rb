class CreateWorkoutSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_sessions do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.integer :total_duration

      t.timestamps
    end
  end
end
