

class WorkoutScheduleGenerator
  WEEKS_AHEAD = 4

  def initialize(user)
    @user = user
  end

  def generate
    last_schedule_date = WorkoutSchedule.where(user: @user).maximum(:date) || Date.current

    start_date = [last_schedule_date, Date.current].max + 1.day
    end_date = start_date + WEEKS_AHEAD.weeks - 1.day

    @user.routines.each do |routine|
      workout_day_index = 0

      # Generate a flat array of workout_days, so we can iterate over them
      # Adjust the day indices to match Ruby's Date#wday
      workout_days = @user.workout_days.flat_map { |workout_day| (workout_day.days_of_week.map { |day| (day+1)%7 }) }.sort

      (start_date..end_date).each do |date|
        # If the date is not a workout day, skip to the next date
        next unless workout_days.include?(date.wday)

        routine_workout = routine.routine_workouts.order(:order)[workout_day_index % routine.routine_workouts.count]

        # Create workout schedules
        WorkoutSchedule.find_or_create_by(
          user: @user,
          routine_workout: routine_workout,
          date: date
        )

        # Increment the workout_day_index to point to next workout_day
        workout_day_index += 1
      end
    end
  end
end
