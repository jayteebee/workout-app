class ConfirmationsController < Devise::ConfirmationsController
    protected

    # def after_confirmation_path_for(resource_name, resource)
    #     'localhost:3000/'
    # end
    
    def redirect_to_frontend
        redirect_to "https://workout-app-fe-five.vercel.app/GettingStarted"
      end

end