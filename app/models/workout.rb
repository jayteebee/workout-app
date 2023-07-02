class Workout < ApplicationRecord
  belongs_to :user
  has_many :routine_workouts, dependent: :destroy
  has_many :routines, through: :routine_workouts
  has_many :workout_exercises, dependent: :destroy
  has_many :exercises, through: :workout_exercises
  has_many :workout_sessions, dependent: :destroy

end
