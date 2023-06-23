class WorkoutScheduleGenerator
WEEKS_AHEAD = 4

def initialize(user)
    @user = user
end

def generate
    # Iterating over each routine belonging to the user
    @user.routines.each do |routine|
        # For each routine, iterate over each routine_workout
        routine.routine_workouts.each do |routine_workout|
            # iterate over each workout_day of the user
            @user.workout_days.each do |workout_day|
                # for each day of the week specified in the workout_day..
                workout_day.days_of_week.each do |day|
                    # calculate next occurrence of that weekday
                    date = next_occurrence(day)
                    # if that date is within our weeks_ahead range
                    if date <= WEEKS_AHEAD.weeks.from_now
                        # find/create a workout_schedule for the user, the routine_workout and the date.
                        WorkoutSchedule.find_or_create_by(
                            user: @user,
                            routine_workout: routine_workout,
                            date: date
                        )
                    end
                end
            end
        end
    end
end

def next_occurrence(wday)
    date = Date.current
    date += 1.day until date.wday == wday
    date    
end
end