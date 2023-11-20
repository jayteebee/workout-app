# class ExercisesController < ApplicationController
#   before_action :set_exercise, only: %i[show update destroy]
#   before_action :authenticate_user!

#   # GET /exercises
#   def index
#     @exercises = current_user.exercises
#     render json: @exercises
#   end

#   # GET /exercises/1
#   def show
#     if @exercise.user_id == current_user.id
#       render json: @exercise
#     else
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end

#   # POST /exercises
#   def create
#     @exercise = current_user.exercises.build(exercise_params)

#     if @exercise.save
#       render json: @exercise, status: :created, location: @exercise
#     else
#       render json: @exercise.errors, status: :unprocessable_entity
#     end
#   end

#   # PATCH/PUT /exercises/1
#   def update
#     if @exercise.user_id == current_user.id
#       if @exercise.update(exercise_params)
#         render json: @exercise
#       else
#         render json: @exercise.errors, status: :unprocessable_entity
#       end
#     else
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end

#   # DELETE /exercises/1
#   def destroy

#     if @exercise.user_id == current_user.id
#       @exercise.destroy
#     else
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end

#   private

#   def set_exercise
#     @exercise = Exercise.find(params[:id])
#   end

#   def exercise_params
#     params.require(:exercise).permit(:name, :sets, :reps, :weight, :duration, :personal_best)
#   end
# end





class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[ show update destroy ]

  # GET /exercises
  def index
    @exercises = Exercise.all

    render json: @exercises
  end

  # GET /exercises/1
  def show
    render json: @exercise
  end

  # POST /exercises
  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      render json: @exercise, status: :created, location: @exercise
    else
      render json: @exercise.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exercises/1
  def update
    if @exercise.update(exercise_params)
      render json: @exercise
    else
      render json: @exercise.errors, status: :unprocessable_entity
    end
  end

  # DELETE /exercises/1
  def destroy
    @exercise.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exercise_params
      params.require(:exercise).permit(:name, :sets, :reps, :weight, :duration, :personal_best)
    end
end