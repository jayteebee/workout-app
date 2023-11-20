# class WorkoutsController < ApplicationController
#   before_action :set_workout_for_show_update_destroy, only: %i[ show update destroy ]
#   before_action :set_workout_for_nested_resources, only: %i[ exercises add_exercise delete_exercise update_exercise ]
#   before_action :authenticate_user!

#   # GET Requests
#   # /workouts
#   def index
#     @workouts = current_user.workouts
#     render json: @workouts
#   end

#   # /workouts/1
#   def show
#     if @workout.user_id == current_user.id
#       render json: @workout
#     else
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end

#   # /workouts/1/exercises
# def exercises
#   if @workout.user_id == current_user.id
#   workout_exercises = @workout.workout_exercises.includes(:exercise)
#   workout_exercises_as_json = workout_exercises.as_json(include: :exercise)

#   workout_exercises_as_json.each do |workout_exercise|
#     workout_exercise["workout_name"] = @workout.name
#   end
#   render json: workout_exercises_as_json
# else
#   render json: { error: 'Unauthorized' }, status: :unauthorized
# end
# end

#   # POST REQUESTS
#   # /workouts
#   def create
#     @workout = current_user.workouts.new(workout_params)

#     if @workout.save
#       render json: @workout, status: :created, location: @workout
#     else
#       render json: @workout.errors, status: :unprocessable_entity
#     end
#   end

#   # PATCH/PUT REQUESTS
#   # /workouts/1
#   def update
#     if @workout.user_id == current_user.id
#     if @workout.update(workout_params)
#       render json: @workout
#     else
#       render json: @workout.errors, status: :unprocessable_entity
#     end
#   else
#     render json: { error: 'Unauthorized' }, status: :unauthorized
#   end
#   end

#   # /workouts/1/exercises/1
#   def update_exercise
#     if @workout.user_id == current_user.id

#     @exercise = Exercise.find(params[:exercise_id])
#     workout_exercise = @workout.workout_exercises.find_by(exercise: @exercise)
#     if workout_exercise.nil?
#     render json: {error: 'Exercise not found in this workout'}, status: :not_found
#     else
#       workout_exercise.sets = params[:sets] if params[:sets]
#       workout_exercise.reps = params[:reps] if params[:reps]
#       workout_exercise.weight = params[:weight] if params[:weight]

#       if workout_exercise.save
#         render json: workout_exercise, status: :ok
#       else
#         render json: workout_exercise.errors, status: :unprocessable_entity
#       end
#     end
#   else
#     render json: { error: 'Unauthorized' }, status: :unauthorized
#   end
#   end

#   # /workouts/1/exercises
# def add_exercise
#   if @workout.user_id == current_user.id

#   @exercise = Exercise.find(params[:exercise_id])
#   workout_exercise = WorkoutExercise.new(workout: @workout, exercise: @exercise)
#   workout_exercise.sets = params[:sets]
#   workout_exercise.reps = params[:reps]
#   workout_exercise.weight = params[:weight]
#   workout_exercise.rest_timer = params[:rest]


#   if workout_exercise .save
#     render json: @workout
#   else
#     render json: workout_exercise.errors, status: :unprocessable_entity
# end
# else
#   render json: { error: 'Unauthorized' }, status: :unauthorized
# end
# end

#   # DELETE REQUESTS
#   # /workouts/1
#   def destroy
#     if @workout.user_id == current_user.id
#       @workout.destroy
#     else
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end

#   # /workouts/1/exercises/1
#   def delete_exercise
#     if @workout.user_id == current_user.id
#     workout_exercise = WorkoutExercise.find_by(workout: @workout, exercise: params[:exercise_id])
#     if workout_exercise
#     workout_exercise.destroy
#     render json: {message: "Exercise removed from workout"}, status: :ok
#     else
#       render json: {error: "Exercise not found in this workout"}, status: :not_found
#   end
# else
#   render json: { error: 'Unauthorized' }, status: :unauthorized
# end
# end
 
#   # def delete_exercise
#   #   @exercise = Exercise.find(params[:exercise_id])
#   #   @workout.exercises.delete(@exercise)
#   # end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_workout_for_show_update_destroy
#       @workout = Workout.find(params[:id])
#     end
    
#     def set_workout_for_nested_resources
#       @workout = Workout.find(params[:workout_id])
#     end

#     # Only allow a list of trusted parameters through.
#     def workout_params
#       params.require(:workout).permit(:name, :duration, :date, :user_id)
#     end
# end


class WorkoutsController < ApplicationController
  before_action :set_workout_for_show_update_destroy, only: %i[ show update destroy ]
  before_action :set_workout_for_nested_resources, only: %i[ exercises add_exercise delete_exercise update_exercise ]

  # GET Requests
  # /workouts
  def index
    @workouts = Workout.all

    render json: @workouts
  end

  # /workouts/1
  def show
    render json: @workout
  end

  # /workouts/1/exercises
def exercises
  workout_exercises = @workout.workout_exercises.includes(:exercise)
  workout_exercises_as_json = workout_exercises.as_json(include: :exercise)

  workout_exercises_as_json.each do |workout_exercise|
    workout_exercise["workout_name"] = @workout.name
  end

  render json: workout_exercises_as_json
end

  # POST REQUESTS
  # /workouts
  def create
    @workout = Workout.new(workout_params)

    if @workout.save
      render json: @workout, status: :created, location: @workout
    else
      render json: @workout.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT REQUESTS
  # /workouts/1
  def update
    if @workout.update(workout_params)
      render json: @workout
    else
      render json: @workout.errors, status: :unprocessable_entity
    end
  end

  # /workouts/1/exercises/1
  def update_exercise
    @exercise = Exercise.find(params[:exercise_id])
    workout_exercise = @workout.workout_exercises.find_by(exercise: @exercise)
    if workout_exercise.nil?
    render json: {error: 'Exercise not found in this workout'}, status: :not_found
    else
      workout_exercise.sets = params[:sets] if params[:sets]
      workout_exercise.reps = params[:reps] if params[:reps]
      workout_exercise.weight = params[:weight] if params[:weight]

      if workout_exercise.save
        render json: workout_exercise, status: :ok
      else
        render json: workout_exercise.errors, status: :unprocessable_entity
      end
    end
  end

  # /workouts/1/exercises
def add_exercise
  @exercise = Exercise.find(params[:exercise_id])
  workout_exercise = WorkoutExercise.new(workout: @workout, exercise: @exercise)
  workout_exercise.sets = params[:sets]
  workout_exercise.reps = params[:reps]
  workout_exercise.weight = params[:weight]
  workout_exercise.rest_timer = params[:rest]


  if workout_exercise .save
    render json: @workout
  else
    render json: workout_exercise.errors, status: :unprocessable_entity
end
end

  # DELETE REQUESTS
  # /workouts/1
  def destroy
    @workout.destroy
  end

  # /workouts/1/exercises/1
  def delete_exercise
    workout_exercise = WorkoutExercise.find_by(workout: @workout, exercise: params[:exercise_id])
    if workout_exercise
    workout_exercise.destroy
    render json: {message: "Exercise removed from workout"}, status: :ok
    else
      render json: {error: "Exercise not found in this workout"}, status: :not_found
  end
end
 
  # def delete_exercise
  #   @exercise = Exercise.find(params[:exercise_id])
  #   @workout.exercises.delete(@exercise)
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout_for_show_update_destroy
      @workout = Workout.find(params[:id])
    end
    
    def set_workout_for_nested_resources
      @workout = Workout.find(params[:workout_id])
    end

    # Only allow a list of trusted parameters through.
    def workout_params
      params.require(:workout).permit(:name, :duration, :date, :user_id)
    end
end