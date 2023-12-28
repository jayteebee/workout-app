class ConfirmationsController < Devise::ConfirmationsController
    protected

      # GET /confirmation?confirmation_token=abcdef
#   def show
def confirm_account
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      # Redirect to the front end confirmation success page
      redirect_to "https://workout-app-fe-five.vercel.app/GettingStarted"
    else
      # Redirect to the front end error page or pass the error messages
      redirect_to "https://workout-app-fe-five.vercel.app/confirmation_error?errors=#{resource.errors.full_messages.join(',')}"
    end
  end

    # def after_confirmation_path_for(resource_name, resource)
    #     'localhost:3000/'
    # end
    
    def redirect_to_frontend
        redirect_to "https://workout-app-fe-five.vercel.app/GettingStarted"
      end

end