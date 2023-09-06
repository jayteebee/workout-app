require 'montrose'

class WorkoutScheduleGenerator
  WEEKS_AHEAD = 12

  def initialize(user)
    puts "user : #{user}"
    @user = user
    puts "USER: #{@user}"
  end

  def generate_schedules(routine_id)
    routine = @user.routines.find_by(id: routine_id)
    puts "ROUTINE: #{routine}"
    return unless routine

    last_schedule_date = routine.routine_workouts.flat_map(&:workout_schedules).maximum(:date) || Date.current
    puts "last_schedule_date : #{last_schedule_date}"

    start_date = [last_schedule_date].max + 1.day
    end_date = start_date + WEEKS_AHEAD.weeks - 1.day

    day_mapping = {
  0 => :Sunday,
  1 => :Monday,
  2 => :Tuesday,
  3 => :Wednesday,
  4 => :Thursday,
  5 => :Friday,
  6 => :Saturday
}

    workout_days = @user.workout_days.flat_map(&:days_of_week).sort
    puts "workout_days : #{workout_days}"

    transformed_days = workout_days.map { |day_number| day_mapping[day_number] }
    puts "transformed_days : #{transformed_days}"

    routine_workouts = routine.routine_workouts.order(:order).to_a
    puts "routine_workouts : #{routine_workouts}"

    recurrence = Montrose.every(:week, on: transformed_days, starts: start_date, until: end_date)

    # Create a hash to map days to routine workouts
    day_to_workout_mapping = {}
    puts "day_to_workout_mapping : #{day_to_workout_mapping}"

    routine_workouts.each do |routine_workout|
      puts "routine_workout inside : #{routine_workout}"

      day = routine_workout.day.first.to_sym
      puts "day : #{day}"

      day_to_workout_mapping[day] ||= []
      day_to_workout_mapping[day] << routine_workout
    end
    puts "day_to_workout_mapping 2 : #{day_to_workout_mapping}"

    wday_to_day_mapping = {
      0 => :Sunday,
      1 => :Monday,
      2 => :Tuesday,
      3 => :Wednesday,
      4 => :Thursday,
      5 => :Friday,
      6 => :Saturday
    }

    recurrence.each do |date|
      day = date.wday  # Get the day of the week for the current date
     puts "day in recurrence #{day}"
     
     day_symbol = wday_to_day_mapping[day]
     puts "day_symbol : #{day_symbol}"

      routine_workouts_for_day = day_to_workout_mapping[day_symbol]
    puts "routine_workouts_for_day #{routine_workouts_for_day}"

      if routine_workouts_for_day.present?
        routine_workout = routine_workouts_for_day.shift  # Get the next routine workout for this day
       puts "routine_workout : #{routine_workout}"
       
        # workout_id = routine_workout.workout_id
        workout_id = routine_workout.id
        puts "workout_id : #{workout_id}"
    
        workout_schedule = WorkoutSchedule.new(
          user_id: @user.id,
          routine_workout_id: workout_id,
          date: date,
          completed: false
        )
    
        if workout_schedule.save
          puts "Workout schedule created for date: #{date} (Routine Workout ID: #{workout_id})"
        else
          puts "Failed to create workout schedule for date: #{date}"
          puts "ERROR: #{workout_schedule.errors.full_messages}"
        end
    
        # Put the routine workout back into the mapping for the next occurrence
        day_to_workout_mapping[day_symbol] << routine_workout
      else
        puts "No routine workout assigned for date: #{date}"
      end
    end
    

end
end
