require 'montrose'

class WorkoutScheduleFrequencyGenerator
  WEEKS_AHEAD = 12

  def initialize(user)
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


    frequency = @user.workout_days.first&.frequency
    puts "frequency : #{frequency}"

    routine_workouts = routine.routine_workouts.order(:order).to_a
    puts "routine_workouts : #{routine_workouts}"

    sorted_routine_workouts = routine_workouts.sort_by { |workout| workout.order }
    puts "sorted_routine_workouts : #{sorted_routine_workouts}"

    # recurrence = Montrose.daily(interval: frequency, between:start_date...end_date)
    recurrence = Montrose.every(frequency.days, starts: start_date, until: end_date)



    recurrence.each do |date|

routine_workout = sorted_routine_workouts.shift
     puts "routine_workout #{routine_workout}"

     if routine_workout.nil?
      puts "No more routine workouts available."
      # Reset the routine workouts to the original order
      sorted_routine_workouts = routine_workouts.sort_by { |workout| workout.order }
      routine_workout = sorted_routine_workouts.shift
      break if routine_workout.nil?  # If still nil, exit the loop
    end

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

    end
    

end
end