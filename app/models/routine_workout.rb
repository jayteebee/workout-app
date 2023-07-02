class RoutineWorkout < ApplicationRecord
  belongs_to :routine
  belongs_to :workout
  has_many :workout_schedules, dependent: :destroy
end
