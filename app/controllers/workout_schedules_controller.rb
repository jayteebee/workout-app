class WorkoutSchedulesController < ApplicationController

    before_action :set_workout_schedule, only: [:show, :update, :destroy]

    # GET REQUESTS
    #  /workout_schedules
    def index
      @workout_schedules = WorkoutSchedule.all
  
      render json: @workout_schedules
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
        render json: @workout_schedule
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
      # Use callbacks to share common setup or constraints between actions.
      def set_workout_schedule
        @workout_schedule = WorkoutSchedule.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def workout_schedule_params
        params.require(:workout_schedule).permit(:user_id, :routine_workout_id, :date)
      end

end
