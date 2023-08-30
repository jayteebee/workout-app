class WorkoutDay < ApplicationRecord
  belongs_to :user
  belongs_to :routine

after_destroy :remove_future_workout_schedules

def remove_future_workout_schedules
  self.routine.workout_schedules.where("date > ?", Date.today).destroy_all
end

end

# self.user.workout_schedules.where("date > ?", Date.today).destroy_all
