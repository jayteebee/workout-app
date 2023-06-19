class Workout < ApplicationRecord
  belongs_to :user
  has_many :routine_workouts
  has_many :routines, through: :routine_workouts
  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises
end
