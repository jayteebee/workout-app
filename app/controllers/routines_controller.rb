class RoutinesController < ApplicationController
  before_action :set_routine, only: %i[ show update destroy workouts add_workout ]

  # GET /routines
  def index
    @routines = Routine.all

    render json: @routines
  end

  # GET /routines/1
  def show
    render json: @routine
  end

# GET /routines/1/workouts
def workouts
  render json: @routine.workouts
end

  # POST /routines
  def create
    @routine = Routine.new(routine_params)

    if @routine.save
      render json: @routine, status: :created, location: @routine
    else
      render json: @routine.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /routines/1
  def update
    if @routine.update(routine_params)
      render json: @routine
    else
      render json: @routine.errors, status: :unprocessable_entity
    end
  end

def add_workout
  @workout = Workout.find(params[:workout_id])
  @routine.workouts << @workout
  if @routine.save
    render json: @routine
  else 
    render json: @root.errors, status: :unprocessable_entity
  end
end

  # DELETE /routines/1
  def destroy
    @routine.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_routine
      @routine = Routine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def routine_params
      params.require(:routine).permit(:name, :frequency, :user_id)
    end
end
