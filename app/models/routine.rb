class Routine < ApplicationRecord
  belongs_to :user
  has_many :routine_workouts
  has_many :workouts, through: :routine_workouts
end
