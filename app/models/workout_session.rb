class WorkoutSession < ApplicationRecord
  belongs_to :workout
  belongs_to :user
  has_many :exercise_sessions
end
