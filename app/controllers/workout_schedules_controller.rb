class WorkoutSchedulesController < ApplicationController

    before_action :set_workout_schedule, only: [:show, :update, :destroy]

    # GET /workout_schedules
    def index
      @workout_schedules = WorkoutSchedule.all
  
      render json: @workout_schedules
    end
  
    # GET /workout_schedules/1
    def show
      render json: @workout_schedule
    end
  
    # POST /workout_schedules
    def create
      @workout_schedule = WorkoutSchedule.new(workout_schedule_params)
  
      if @workout_schedule.save
        render json: @workout_schedule, status: :created
      else
        render json: @workout_schedule.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /workout_schedules/1
    def update
      if @workout_schedule.update(workout_schedule_params)
        render json: @workout_schedule
      else
        render json: @workout_schedule.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /workout_schedules/1
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
