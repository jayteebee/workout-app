class WorkoutSchedule < ApplicationRecord
  belongs_to :user
  belongs_to :routine_workout
end
