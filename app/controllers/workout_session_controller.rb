# class WorkoutSessionController < ApplicationController

#   before_action :set_workout_session, only: [:show, :update, :destroy ]

#   # GET REQUESTS
#   # /workout_session
#   def index
#       @workout_sessions = current_user.workout_sessions.all
#       render json: @workout_sessions
#   end

#   # /workout_session/1
#   def show
#       render json: @workout_session
#   end

#   # POST REQUESTS
#   # /workout_session
#   def create
#       @workout_session = current_user.workout_sessions.new(workout_session_params)

#       if @workout_session.save
#           render json: @workout_session, status: :created
#         else
#           render json: @workout_session.errors, status: :unprocessable_entity
#         end
#   end


#   # PATCH/PUT REQUESTS
#   # /workout_session/1
#   def update
#       if @workout_session.update(workout_session_params)
#           if @workout_session.total_duration
#               SessionLog.create!(
#                 user_id: @workout_session.user_id,
#                 details: @workout_session.as_json,
#                 workout_name: @workout_session.workout_name
#               )
#             end
          

#           render json: @workout_session, status: :ok
#         else
#           render json: @workout_session.errors, status: :unprocessable_entity
#         end
#   end

# # DELETE REQUESTS   
# # /workout_session/1
#   def destroy
#       @workout_session.destroy
#   end

  
#   private

#   def set_workout_session
#       @workout_session = current_user.workout_sessions.find(params[:id])
#   end

#   def workout_session_params
#       params.require(:workout_session).permit(:user_id, :routine_workout_id, :date, :total_duration, :workout_name)
#     end
# end

class WorkoutSessionController < ApplicationController

  before_action :set_workout_session, only: [:show, :update, :destroy ]

  # GET REQUESTS
  # /workout_session
  def index
      @workout_sessions = WorkoutSession.all
      render json: @workout_sessions
  end

  # /workout_session/1
  def show
      render json: @workout_session
  end

  # POST REQUESTS
  # /workout_session
  def create
      @workout_session = WorkoutSession.new(workout_session_params)

      if @workout_session.save
          render json: @workout_session, status: :created
        else
          render json: @workout_session.errors, status: :unprocessable_entity
        end
  end


  # PATCH/PUT REQUESTS
  # /workout_session/1
  def update
      if @workout_session.update(workout_session_params)
          if @workout_session.total_duration
              SessionLog.create!(
                user_id: @workout_session.user_id,
                details: @workout_session.as_json,
                workout_name: @workout_session.workout_name
              )
            end
          

          render json: @workout_session, status: :ok
        else
          render json: @workout_session.errors, status: :unprocessable_entity
        end
  end

# DELETE REQUESTS   
# /workout_session/1
  def destroy
      @workout_session.destroy
  end

  
  private

  def set_workout_session
      @workout_session = WorkoutSession.find(params[:id])
  end

  def workout_session_params
      params.require(:workout_session).permit(:user_id, :routine_workout_id, :date, :total_duration, :workout_name)
    end
end