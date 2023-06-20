class WorkoutsController < ApplicationController
  before_action :set_workout, only: %i[ show update destroy exercises ]

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
render json: @workout.exercises
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

def add_exercise
  @exercise = Exercise.find(params[:exercise_id])
  @workout.exercises << @exercise
  if @workout.save
    render json: @workout
  else
    render json: @root.errors, status: :unprocessable_entity
end
end

  # DELETE REQUESTS
  # /workouts/1
  def destroy
    @workout.destroy
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
