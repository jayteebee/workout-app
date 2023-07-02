require "test_helper"

class SessionLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get session_logs_index_url
    assert_response :success
  end

  test "should get show" do
    get session_logs_show_url
    assert_response :success
  end

  test "should get create" do
    get session_logs_create_url
    assert_response :success
  end

  test "should get update" do
    get session_logs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get session_logs_destroy_url
    assert_response :success
  end
end
