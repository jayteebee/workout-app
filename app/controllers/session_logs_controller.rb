# class SessionLogsController < ApplicationController
#   before_action :set_session_log, only: [:show, :update, :destroy]
#   before_action :authenticate_user!


#   def index
#     @session_logs = current_user.session_logs
#     render json: @session_logs
#   end

#   def show
#     # Ensure that the requested session log belongs to the current user
#     if @session_log.user_id == current_user.id
#       render json: @session_log
#     else
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end

#   def create
#     @session_log = current_user.session_logs.build(session_log_params)
#     if @session_log.save
#       render json: @session_log, status: :created
#     else
#       render json: @session_log.errors, status: :unprocessable_entity
#     end
#   end

#   def update

#     if @session_log.user_id == current_user.id
#       if @session_log.update(session_log_params)
#         render json: @session_log
#       else
#         render json: @session_log.errors, status: :unprocessable_entity
#       end
#     else
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end

#   def destroy

#     if @session_log.user_id == current_user.id
#       @session_log.destroy
#       render json: { message: 'Session log successfully deleted' }, status: :ok
#     else
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end

#   private

#   def set_session_log
#     @session_log = SessionLog.find(params[:id])
#   end

#   def session_log_params
#     params.require(:session_log).permit(:user_id, details: {})
#   end
# end


class SessionLogsController < ApplicationController
  before_action :set_session_log, only: [:show, :update, :destroy]

  def index
    @session_logs = SessionLog.all
    render json: @session_logs
  end

  def show
    render json: @session_log
  end

  def create
    @session_log = SessionLog.new(session_log_params)
    if @session_log.save
      render json: @session_log, status: :created
    else
      render json: @session_log.errors, status: :unprocessable_entity
    end
  end

  

  def update
    if @session_log.update(session_log_params)
      render json: @session_log
    else
      render json: @session_log.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @session_log.destroy
    render json: {message: 'Session log successfully deleted'}, status: :ok
  end

  private

  def set_session_log
    @session_log = SessionLog.find(params[:id])
  end

  def session_log_params
    params.require(:session_log).permit(:user_id, details: {})
  end
end