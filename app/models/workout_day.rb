class WorkoutDay < ApplicationRecord
  belongs_to :user

after_destroy :remove_future_workout_schedules

def remove_future_workout_schedules
  self.user.workout_schedules.where("date > ?", Date.today).destroy_all
end

end
