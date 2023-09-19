class RenameWorkoutIdToRoutineWorkoutIdInWorkoutSessions < ActiveRecord::Migration[7.0]
  def change
    rename_column :workout_sessions, :workout_id, :routine_workout_id
  end
end
