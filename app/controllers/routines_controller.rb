class RoutinesController < ApplicationController
  before_action :set_routine_for_show_update_destroy, only: %i[ show update destroy ]
  before_action :set_routine_for_nested_resources, only: %i[ workouts add_workout delete_workout ]
  before_action :authenticate_user!

  # GET REQUESTS
  # /routines
  def index
    @routines = current_user.routines
    render json: @routines
  end

  # /routines/1
  def show
    # Ensure that the requested routine belongs to the current user
    if @routine.user_id == current_user.id
      render json: @routine
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # /routines/1/workouts
  def workouts
    # Ensure that the requested routine belongs to the current user
    if @routine.user_id == current_user.id
      @routine_workouts = @routine.routine_workouts.includes(:workout)
      render json: @routine_workouts.as_json(include: { routine: { only: :name }, workout: {} })
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # POST REQUESTS
  # /routines
  def create
    @routine = current_user.routines.build(routine_params)

    if @routine.save
      render json: @routine, status: :created, location: @routine
    else
      render json: @routine.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT REQUESTS
  # /routines/1
  def update
    # Ensure that the requested routine belongs to the current user
    if @routine.user_id == current_user.id
      if @routine.update(routine_params)
        render json: @routine
      else
        render json: @routine.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # /routines/1/workouts
  def add_workout
    # Ensure that the requested routine belongs to the current user
    if @routine.user_id == current_user.id
      @workout = Workout.find(params[:workout_id])
      @routine.routine_workouts.create(workout: @workout, order: params[:order], day: params[:day])
      if @routine.save
        render json: @routine
      else
        render json: @routine.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # DELETE REQUESTS
  # /routines/1
  def destroy
    # Ensure that the requested routine belongs to the current user
    if @routine.user_id == current_user.id
      @routine.destroy
      render json: { message: 'Routine deleted successfully' }
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def delete_workout
    # Ensure that the requested routine belongs to the current user
    if @routine.user_id == current_user.id
      @workout = Workout.find(params[:workout_id])
      routine_workout = RoutineWorkout.find_by(routine: @routine, workout: @workout)
      if routine_workout
        routine_workout.destroy
        render json: { message: 'Workout deleted from routine' }
      else
        render json: { error: 'Workout not found' }, status: :not_found
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_routine_for_show_update_destroy
    @routine = Routine.find(params[:id])
  end

  def set_routine_for_nested_resources
    @routine = Routine.find(params[:routine_id])
  end

  # Only allow a list of trusted parameters through.
  def routine_params
    params.require(:routine).permit(:name, :frequency, :user_id)
  end
end





# class RoutinesController < ApplicationController
#   before_action :set_routine_for_show_update_destroy, only: %i[ show update destroy ]
#   before_action :set_routine_for_nested_resources, only: %i[ workouts add_workout delete_workout ]

#   # GET REQUESTS
#   # /routines
#   def index
#     @routines = Routine.all

#     render json: @routines
#   end

#   # /routines/1
#   def show
#     render json: @routine
#   end

# # /routines/1/workouts
# def workouts
#   @routine_workouts = @routine.routine_workouts.includes(:workout)
#   render json: @routine_workouts.as_json(include: {routine: {only: :name}, workout: {}})
# end
# # def workouts
# #   render json: @routine.workouts
# # end


#   # POST REQUESTS
#   # /routines
#   def create
#     @routine = Routine.new(routine_params)

#     if @routine.save
#       render json: @routine, status: :created, location: @routine
#     else
#       render json: @routine.errors, status: :unprocessable_entity
#     end
#   end

#   # PATCH/PUT REQUESTS
#   # /routines/1
#   def update
#     if @routine.update(routine_params)
#       render json: @routine
#     else
#       render json: @routine.errors, status: :unprocessable_entity
#     end
#   end

#   # /routines/1/workouts
# def add_workout
#   @workout = Workout.find(params[:workout_id])
#   @routine.routine_workouts.create(workout: @workout, order: params[:order], day: params[:day])
#   if @routine.save
#     render json: @routine
#   else 
#     render json: @routine.errors, status: :unprocessable_entity
#   end
# end

# # def add_workout
# #   @workout = Workout.find(params[:workout_id])
# #   @routine.workouts << @workout
# #   if @routine.save
# #     render json: @routine
# #   else 
# #     render json: @root.errors, status: :unprocessable_entity
# #   end
# # end

#   # DELETE REQUESTS
#   # /routines/1
#   def destroy
#     @routine.destroy
#     render json: { message: 'Routine deleted successfully' }
#   end

# def delete_workout
#   @workout = Workout.find(params[:workout_id])
#   routine_workout = RoutineWorkout.find_by(routine: @routine, workout: @workout)
#   if routine_workout
#   routine_workout.destroy
#   render json: {message: "Workout deleted from routine"}
#   else
#     render json: {error: "Workout not found"}, status: :not_found
#   end
# end

#   private
#     # Use callbacks to share common setup or constraints between actions.
    
#     def set_routine_for_show_update_destroy
#       @routine = Routine.find(params[:id])
#     end
    
#     def set_routine_for_nested_resources
#       @routine = Routine.find(params[:routine_id])
#     end

#     # Only allow a list of trusted parameters through.
#     def routine_params
#       params.require(:routine).permit(:name, :frequency, :user_id)
#     end
# end