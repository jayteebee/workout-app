class ConfirmationsController < Devise::ConfirmationsController

      # GET /confirmation?confirmation_token=abcdef
#   def show
def confirm_account
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
  
    if resource.errors.empty?
      # Return a JSON response instead of redirecting
      render json: { status: 'success', message: 'Account confirmed successfully' }, status: :ok
    else
      # Return error details in the JSON response
      render json: { status: 'error', errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

    # def after_confirmation_path_for(resource_name, resource)
    #     'localhost:3000/'
    # end
    
    # def redirect_to_frontend
    #     redirect_to "https://workout-app-fe-five.vercel.app/GettingStarted"
    #   end

end