class WorkoutDaysController < ApplicationController

    before_action :set_workout_day, only: [:show, :update, :destroy]
    before_action :authenticate_user!


    # GET REQUESTS
    
    #  /workout_days
    def index
      @workout_days = current_user.workout_days
      render json: @workout_days
    end
  
    # /workout_days/1
    def show
      if @workout_day.user_id == current_user.id
        render json: @workout_day
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    # POST REQUESTS
    # /workout_days
    def create
      @workout_day = current_user.workout_days.new(workout_day_params)
      if @workout_day.save
    return unless @workout_day.user_id && @workout_day.routine_id

        WorkoutScheduleRegenerationJob.perform_async(@workout_day.user_id, @workout_day.routine_id)
        render json: @workout_day, status: :created
      else
        render json: @workout_day.errors, status: :unprocessable_entity
      end
    end
  

    # workout_days_frequency
    def frequency
      @workout_day = current_user.workout_days.new(workout_day_params)
      if @workout_day.save
        WorkoutScheduleFrequencyRegenerationJob.perform_async(@workout_day.user_id, @workout_day.routine_id)
        render json: @workout_day, status: :created
      else
        @workout_day.errors.add(:base, "Error")
        render json: @workout_day.errors, status: :unprocessable_entity
      end
    end
  
  
    # PATCH/PUT REQUESTS
    #  /workout_days/1
    def update
      if @workout_day.user_id == current_user.id
        if @workout_day.update(workout_day_params)
          render json: @workout_day
        else
          render json: @workout_day.errors, status: :unprocessable_entity
        end
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    # DELETE REQUESTS
    # /workout_days/1
    def destroy
      if @workout_day.user_id == current_user.id
        @workout_day.destroy
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_workout_day
        @workout_day = WorkoutDay.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def workout_day_params
        params.require(:workout_day).permit(:user_id, :routine_id, :frequency, days_of_week: []  )
      end

end



# class WorkoutDaysController < ApplicationController

#   before_action :set_workout_day, only: [:show, :update, :destroy]

#   # GET REQUESTS
  
#   #  /workout_days
#   def index
#     @workout_days = WorkoutDay.all

#     render json: @workout_days
#   end

#   # /workout_days/1
#   def show
#     render json: @workout_day
#   end

#   # POST REQUESTS
#   /workout_days
#   def create
#     @workout_day = WorkoutDay.new(workout_day_params)
#     if @workout_day.save
      
#       WorkoutScheduleRegenerationJob.perform_async(@workout_day.user_id, @workout_day.routine_id)
#       render json: @workout_day, status: :created
#     else
#       render json: @workout_day.errors, status: :unprocessable_entity
#     end
#   end

#   # /workout_days_frequency
#   def frequency
#     @workout_day = WorkoutDay.new(workout_day_params)
#     if @workout_day.save
#       # change to new one
#       WorkoutScheduleFrequencyRegenerationJob.perform_async(@workout_day.user_id, @workout_day.routine_id)
#       render json: @workout_day, status: :created
#     else
#       @workout_day.errors.add(:base, "Error")
#       render json: @workout_day.errors, status: :unprocessable_entity
#     end
#   end

#   # PATCH/PUT REQUESTS
#   #  /workout_days/1
#   def update
#     if @workout_day.update(workout_day_params)
#       render json: @workout_day
#     else
#       render json: @workout_day.errors, status: :unprocessable_entity
#     end
#   end

#   # DELETE REQUESTS
#   # /workout_days/1
#   def destroy
#     @workout_day.destroy
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_workout_day
#       @workout_day = WorkoutDay.find(params[:id])
#     end

#     # Only allow a trusted parameter "white list" through.
#     def workout_day_params
#       params.require(:workout_day).permit(:user_id, :routine_id, :frequency, days_of_week: []  )
#     end

# end