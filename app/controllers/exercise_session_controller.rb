class ExerciseSessionController < ApplicationController

    before_action :set_exercise_session, only: [:show, :update, :destroy ]

    # GET REQUESTS
    # /exercise_session
    def index
        @exercise_sessions = ExerciseSession.all
        render json: @exercise_sessions
    end

    # /exercise_session/1
    def show
        render json: @exercise_session
    end

    # POST REQUESTS
    # /exercise_session
    def create
        @exercise_session = ExerciseSession.new(exercise_session_params)

        if @exercise_session.save
            render json: @exercise_session, status: :created
          else
            render json: @exercise_session.errors, status: :unprocessable_entity
          end
    end


    # PATCH/PUT REQUESTS
    # /exercise_session/1
    def update
        if @exercise_session.update(exercise_session_params)
            render json: @exercise_session, status: :ok
          else
            render json: @exercise_session.errors, status: :unprocessable_entity
          end
    end

# DELETE REQUESTS   
# /exercise_session/1
    def destroy
        @exercise_session.destroy
    end

    
    private

    def set_exercise_session
        @exercise_session = ExerciseSession.find(params[:id])
    end

    def exercise_session_params
        params.require(:exercise_session).permit(:workout_session_id, :exercise_id, :sets_completed, :reps_completed, :weight_used)
      end

end
