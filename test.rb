require 'montrose'

WEEKS_AHEAD = 12

routine = 1

frequency = 4

last_schedule_date = Date.current
puts "last_schedule_date : #{last_schedule_date}"

start_date = [last_schedule_date].max + 1.day
puts "start_date #{start_date}"

end_date = start_date + WEEKS_AHEAD.weeks - 1.day
puts "end_date #{end_date}"

# this will be a RoutineWorkout Hash
routine_workouts = 1

sorted_routine_workouts = routine_workouts.sort_by { |workout| workout.order }

recurrence = Montrose.daily(interval: frequency, starts: start_date, until: end_date)

recurrence.each do |date|
puts date

routine_workout = sorted_routine_workouts.shift
puts "routine_workout #{routine_workout}"

if routine_workout.nil?
    puts "No more routine workouts available."
    break
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