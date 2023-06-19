require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise = exercises(:one)
  end

  test "should get index" do
    get exercises_url, as: :json
    assert_response :success
  end

  test "should create exercise" do
    assert_difference("Exercise.count") do
      post exercises_url, params: { exercise: { duration: @exercise.duration, name: @exercise.name, personal_best: @exercise.personal_best, reps: @exercise.reps, sets: @exercise.sets, weight: @exercise.weight } }, as: :json
    end

    assert_response :created
  end

  test "should show exercise" do
    get exercise_url(@exercise), as: :json
    assert_response :success
  end

  test "should update exercise" do
    patch exercise_url(@exercise), params: { exercise: { duration: @exercise.duration, name: @exercise.name, personal_best: @exercise.personal_best, reps: @exercise.reps, sets: @exercise.sets, weight: @exercise.weight } }, as: :json
    assert_response :success
  end

  test "should destroy exercise" do
    assert_difference("Exercise.count", -1) do
      delete exercise_url(@exercise), as: :json
    end

    assert_response :no_content
  end
end
