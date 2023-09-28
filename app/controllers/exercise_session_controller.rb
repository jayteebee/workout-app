class ExerciseSessionController < ApplicationController
    before_action :set_exercise_session, only: [:show, :update, :destroy]
    before_action :authenticate_user!
  
    # GET /exercise_session
    def index
      @exercise_sessions = current_user.exercise_sessions
      render json: @exercise_sessions
    end
  
    # /exercise_session/1
    def show
      if @exercise_session.workout_session.user.user_id == current_user.id
        render json: @exercise_session
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    # POST /exercise_session
    def create
      workout_session = WorkoutSession.find(params[:workout_session_id])
  
      if workout_session.user_id == current_user.id
        @exercise_session = ExerciseSession.new(exercise_session_params)
        workout_session.exercise_sessions << @exercise_session
  
        if @exercise_session.save
          render json: @exercise_session, status: :created
        else
          render json: @exercise_session.errors, status: :unprocessable_entity
        end
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    # PATCH/PUT REQUESTS
    # /exercise_session/1
    def update

      if @exercise_session.workout_session.user.user_id == current_user.id
        if @exercise_session.update(exercise_session_params)
          render json: @exercise_session, status: :ok
        else
          render json: @exercise_session.errors, status: :unprocessable_entity
        end
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    # DELETE REQUESTS
    # /exercise_session/1
    def destroy

      if @exercise_session.workout_session.user.user_id == current_user.id
        @exercise_session.destroy
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def set_exercise_session
      @exercise_session = ExerciseSession.find(params[:id])
    end
  
    def exercise_session_params
      params.require(:exercise_session).permit(:workout_session_id, :exercise_id, :sets_completed, :reps_completed, :weight_used, :set_timer)
    end
  end
  