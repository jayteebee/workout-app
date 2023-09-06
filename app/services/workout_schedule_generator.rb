# class WorkoutScheduleGenerator
#   WEEKS_AHEAD = 12

#   def initialize(user)
#     @user = user
#   end

#   def generate_schedules(routine_id)
#     routine = @user.routines.find_by(id: routine_id)
#     return unless routine


#     # on first iteration of the WSG, the routine has no schedules yet thus default to the current date
#     last_schedule_date = routine.routine_workouts.flat_map(&:workout_schedules).maximum(:date) || Date.current
    
#     start_date = [last_schedule_date].max + 1.day #, Date.current - this was inside the array 
#     end_date = start_date + WEEKS_AHEAD.weeks - 1.day

#       workout_day_index = 0

#       #  Generate a flat array of workout_days, so we can iterate over them
#       #  Adjust the day indices to match Ruby's Date#wday
#       # This is the part where workout days are mapped from days of week user input to monday to sunday
#       # workout_days = @user.workout_days.flat_map { |workout_day| (workout_day.days_of_week.map { |day| (day+1)%7 }) }.sort
#       workout_days = @user.workout_days.flat_map { |workout_day| workout_day.days_of_week.sort }.sort
#     puts "workout_days: #{workout_days}"

#     first_workout_day = workout_days.first

#       (start_date..end_date).each do |date|
#         # If the date is not a workout day, skip to the next date
#         next unless workout_days.include?(date.wday)
#         puts "workout_days.include?(date.wday) #{workout_days.include?(date.wday)} ON DATE: #{date}"

#         routine_workout = routine.routine_workouts.order(:order)[workout_day_index % routine.routine_workouts.count]
#         puts "routine workout: #{routine_workout}"

#          # Calculate the index of the workout day within the selected workout days
#       workout_day_in_user_input = date.wday
#       puts "workout_day_in_user_input: #{workout_day_in_user_input}"

#       workout_day_in_routine = routine.routine_workouts.find_index(routine_workout)
#       puts "workout_day_in_routine: #{workout_day_in_routine}"

#       # Calculate the offset to match the workout day in the routine
#       offset = (workout_day_in_user_input - workout_day_in_routine + workout_days.count - workout_days.index(first_workout_day)) % workout_days.count
#       puts "offset: #{offset}"

#       # Calculate the final date based on the offset
#       date = date - offset.days
#       puts "DATE 2: #{date}"

#        # Create workout schedules
#         WorkoutSchedule.find_or_create_by(
#           user: @user,
#           routine_workout: routine_workout,
#           date: date
#         )
  
#         #  Increment the workout_day_index to point to next workout_day
#         workout_day_index += 1 
#     end
#   end
# end





# class WorkoutScheduleGenerator
#   WEEKS_AHEAD = 12

#   def initialize(user)
#     @user = user
#   end

#   def generate_schedules(routine_id)
#     routine = @user.routines.find_by(id: routine_id)
#     return unless routine

#     # on the first iteration of the WSG, the routine has no schedules yet thus defaults to the current date
#     last_schedule_date = routine.routine_workouts.flat_map(&:workout_schedules).maximum(:date) || Date.current

#     start_date = [last_schedule_date].max + 1.day
#     end_date = start_date + WEEKS_AHEAD.weeks - 1.day

#     workout_day_index = 0

#     # Get the user's selected workout days
#     workout_days = @user.workout_days.flat_map(&:days_of_week).sort
#     puts "workout_days: #{workout_days}"

#     # Create a hash to store the workout days and their corresponding routine workouts
#     workout_day_to_routine = {}
#     routine.routine_workouts.order(:order).each do |routine_workout|
#       workout_day = workout_days[workout_day_index % workout_days.count]
#       workout_day_to_routine[workout_day] = routine_workout
#       workout_day_index += 1
#     end
# puts "workout_day_to_routine #{workout_day_to_routine}"
#     (start_date..end_date).each do |date|
#       # If the date is not a workout day, skip to the next date
#       next unless workout_days.include?(date.wday)
#       puts "workout_days.include?(date.wday) true ON DATE: #{date}"

#       # Get the corresponding routine workout for the current workout day
#       routine_workout = workout_day_to_routine[date.wday]
#       puts "routine workout: #{routine_workout}"

#       # Create workout schedules
#       WorkoutSchedule.find_or_create_by(
#         user: @user,
#         routine_workout: routine_workout,
#         date: date
#       )
#     end
#   end
# end



# require 'montrose'

# class WorkoutScheduleGenerator
#   WEEKS_AHEAD = 12

#   def initialize(user)
#     @user = user
#   end

#   def generate_schedules(routine_id)
#     routine = @user.routines.find_by(id: routine_id)
#     puts "ROUTINE: #{routine}"
#     return unless routine

#     last_schedule_date = routine.routine_workouts.flat_map(&:workout_schedules).maximum(:date) || Date.current
#     puts "last_schedule_date : #{last_schedule_date}"

#     start_date = [last_schedule_date].max + 1.day
#     end_date = start_date + WEEKS_AHEAD.weeks - 1.day

#     workout_days = @user.workout_days.flat_map(&:days_of_week).sort
#     puts "workout_days : #{workout_days}"

#     routine_workouts = routine.routine_workouts.order(:order).to_a
#     puts "routine_workouts : #{routine_workouts}"
#     routine_workout_index = 0

#     Montrose.every(:week, on: [:monday, :wednesday, :friday], starts: start_date, until: end_date) do |date|
#       puts "Generating WorkoutSchedule for date: #{date}"
#       routine_workout = routine_workouts[routine_workout_index % routine_workouts.count]
#       puts "routine_workout : #{routine_workout}"
#       routine_workout_index += 1


#       WorkoutSchedule.find_or_create_by(
#         user: @user,
#         routine_workout: routine_workout,
#         date: date
#       )
#     end
#   end
# end




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





    # recurrence = Montrose.every(:week, on: transformed_days , starts: start_date, until: end_date)

    # recurrence.each_with_index do |date, index|
    #   # Extract the workout_id from the routine_workout objects using modulo
    #   workout_id = routine_workouts[index % routine_workouts.length].workout_id
      
    #  # Create a new WorkoutSchedule object with the provided attributes
    #  workout_schedule = WorkoutSchedule.new(
    #     user_id: @user.id,
    #     routine_workout_id: workout_id,
    #     date: date,
    #     completed: false
    #   )
    
    #   # Save the WorkoutSchedule record
    #   if workout_schedule.save
    #     puts "Workout schedule created for date: #{date}"
    #   else
    #     puts "Failed to create workout schedule for date: #{date}"
    #     puts workout_schedule.errors.full_messages
    #   end
    # end