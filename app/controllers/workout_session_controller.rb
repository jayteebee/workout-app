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

    
    

end
