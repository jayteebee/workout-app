# class WorkoutSchedulesController < ApplicationController

#     before_action :set_workout_schedule, only: [:show, :update, :destroy]
#     before_action :authenticate_user!

#     # GET REQUESTS
#     #  /workout_schedules
#     def index
#       @workout_schedules = current_user.workout_schedules.includes(routine_workout: :workout).all
  
#       response_data = @workout_schedules.map do |schedule|
#         {
#           id: schedule.id,
#           user_id: schedule.user_id,
#           routine_workout_id: schedule.routine_workout_id,
#           date: schedule.date,
#           workout_name: schedule.routine_workout.workout.name, 
#           created_at: schedule.created_at,
#           updated_at: schedule.updated_at,
#           completed: schedule.completed
#         }
#       end
  
#       render json: response_data
#     end
  
#     # /workout_schedules/1
#     def show
#       if @workout_schedule.user_id == current_user.id
#       render json: @workout_schedule
#       else
#         render json: {error: "Unauthorized: User ID does not match current user ID"}, status: :Unauthorized
#       end
#     end
  
#     # fetch all workoutschedule entries for a user within the date range
# def user_schedules
#   start_date = params[:start_date].to_date
#   end_date = params[:end_date].to_date
#   user = User.find(params[:id])

#   if user == current_user
#     @workout_schedules = user.workout_schedules.where(date: start_date..end_date)
#       render json: @workout_schedules, status: :ok
#   else
#     render json: {error: "Unauthorized: User does not match current user"}, status: :Unauthorized
#   end
# end


#     # POST REQUESTS
#     #  /workout_schedules
#     def create
#       @workout_schedule = current_user.workout_schedules.new(workout_schedule_params)
  
#       if @workout_schedule.save
#         render json: @workout_schedule, status: :created
#       else
#         render json: @workout_schedule.errors, status: :unprocessable_entity
#       end
#     end

#     # PATCH/PUT REQUESTS
#     #  /workout_schedules/1
#     def update
#       if @workout_schedule.user_id == current_user.id
#         if @workout_schedule.update(workout_schedule_params)
#           render json: @workout_schedule, status: :ok
#         else
#           render json: @workout_schedule.errors, status: :unprocessable_entity
#        end
#       else
#         render json: {error: "Unauthorized: User ID does not match current user ID"}, status: :Unauthorized
#      end
#     end
  
#     # DELETE REQUESTS
#     #  /workout_schedules/1
#     def destroy
#       if @workout_schedule.user_id == current_user.id
#       @workout_schedule.destroy
#       else
#         render json: {error: "Unauthorized: User ID does not match current user ID"}, status: :Unauthorized
#     end
#   end
  
#     private

#       def set_workout_schedule
#         @workout_schedule = WorkoutSchedule.find(params[:id])
#       end
  

#       def workout_schedule_params
#         params.require(:workout_schedule).permit(:user_id, :routine_workout_id, :date, :completed)
#       end

# end


class WorkoutSchedulesController < ApplicationController

  before_action :set_workout_schedule, only: [:show, :update, :destroy]

  # GET REQUESTS
  #  /workout_schedules
  def index
    @workout_schedules = WorkoutSchedule.includes(routine_workout: :workout).all

    response_data = @workout_schedules.map do |schedule|
      {
        id: schedule.id,
        user_id: schedule.user_id,
        routine_workout_id: schedule.routine_workout_id,
        date: schedule.date,
        workout_name: schedule.routine_workout.workout.name, 
        created_at: schedule.created_at,
        updated_at: schedule.updated_at,
        completed: schedule.completed
      }
    end

    render json: response_data
  end

  # /workout_schedules/1
  def show
    render json: @workout_schedule
  end

  # fetch all workoutschedule entries for a user within the date range
def user_schedules
start_date = params[:start_date].to_date
end_date = params[:end_date].to_date
user = User.find(params[:id])
@workout_schedules = user.workout_schedules.where(date: start_date..end_date)

render json: @workout_schedules, status: :ok
end


  # POST REQUESTS
  #  /workout_schedules
  def create
    @workout_schedule = WorkoutSchedule.new(workout_schedule_params)

    if @workout_schedule.save
      render json: @workout_schedule, status: :created
    else
      render json: @workout_schedule.errors, status: :unprocessable_entity
    end
  end



  # PATCH/PUT REQUESTS
  #  /workout_schedules/1
  def update
    if @workout_schedule.update(workout_schedule_params)
      render json: @workout_schedule, status: :ok
    else
      render json: @workout_schedule.errors, status: :unprocessable_entity
    end
  end

  # DELETE REQUESTS
  #  /workout_schedules/1
  def destroy
    @workout_schedule.destroy
  end

  private

    def set_workout_schedule
      @workout_schedule = WorkoutSchedule.find(params[:id])
    end


    def workout_schedule_params
      params.require(:workout_schedule).permit(:user_id, :routine_workout_id, :date, :completed)
    end

end