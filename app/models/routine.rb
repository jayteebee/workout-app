class Routine < ApplicationRecord
  belongs_to :user
  has_many :routine_workouts, dependent: :destroy
  has_many :workouts, through: :routine_workouts

after_destroy :remove_future_workout_schedules

def remove_future_workout_schedules
  self.routine_workouts.each do |routine_workout|
    WorkoutSchedule.where("date > ? AND routine_workout_id = ?", Date.today, routine_workout.id).destroy_all
end
end 
end


