class SessionLogsController < ApplicationController
before_action :set_session_log

  def index
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
