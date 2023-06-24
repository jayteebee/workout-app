class WorkoutSessionController < ApplicationController

    # GET REQUESTS
    # /workout_sessions
    def index
        @workout_sessions = WorkoutSession.all
        render json: @workout_sessions
    end


    def show

    end


    def create

    end


    def update

    end


    def destroy

    end

    
    private

    def set_workout_session
        @workout_session = WorkoutSession.find(params[:id])
    end


end
