class WorkoutSessionController < ApplicationController

    before_action :set_workout_session, only: [:show ]

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
            render json: @workout_session, status: :ok
          else
            render json: @workout_session.errors, status: :unprocessable_entity
          end
    end


    def destroy

    end

    
    private

    def set_workout_session
        @workout_session = WorkoutSession.find(params[:id])
    end

    def workout_session_params
        params.require(:workout_session).permit(:user_id, :workout_id, :date, :total_duration)
      end
end
