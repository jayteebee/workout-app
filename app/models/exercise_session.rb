class ExerciseSession < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout_session
end
