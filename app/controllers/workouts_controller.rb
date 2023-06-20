class WorkoutsController < ApplicationController
  before_action :set_workout, only: %i[ show update destroy exercises add_exercise delete_exercise update_exercise ]

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
render json: workout_exercises, include: :exercise
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
    @exercise = Exercise.find(params[:exercise_id])
    @workout.exercises.delete(@exercise)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:workout_id])
    end

    # Only allow a list of trusted parameters through.
    def workout_params
      params.require(:workout).permit(:name, :duration, :date, :user_id)
    end
end
