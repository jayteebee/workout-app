class SessionLogsController < ApplicationController
before_action :set_session_log, only: [:show, :update, :destroy ]

# GET REQUEST
# /session_logs
  def index
    @session_log = SessionLog.all
    
    render json: @session_log
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

  def set_session_log
    @session_log = SessionLog.find(params[:id])
  end
end
