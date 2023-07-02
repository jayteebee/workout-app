class WorkoutDaysController < ApplicationController

    before_action :set_workout_day, only: [:show, :update, :destroy]

    # GET REQUESTS
    
    #  /workout_days
    def index
      @workout_days = WorkoutDay.all
  
      render json: @workout_days
    end
  
    # /workout_days/1
    def show
      render json: @workout_day
    end
  
    # POST REQUESTS
    # /workout_days
    def create
      @workout_day = WorkoutDay.new(workout_day_params)
  
      if @workout_day.save
        WorkoutScheduleRegenerationJob.perform_async
        render json: @workout_day, status: :created
      else
        render json: @workout_day.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT REQUESTS
    #  /workout_days/1
    def update
      if @workout_day.update(workout_day_params)
        render json: @workout_day
      else
        render json: @workout_day.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE REQUESTS
    # /workout_days/1
    def destroy
      @workout_day.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_workout_day
        @workout_day = WorkoutDay.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def workout_day_params
        params.require(:workout_day).permit(:user_id, days_of_week: [] )
      end

end
