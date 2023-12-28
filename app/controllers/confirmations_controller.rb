class ConfirmationsController < Devise::ConfirmationsController

def confirm_account
    puts "confirm_account ACTIVE ***************"
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
  
    if resource.errors.empty?
      # Return a JSON response instead of redirecting
      render json: { status: 'success', message: 'Account confirmed successfully' }, status: :ok
    else
      # Return error details in the JSON response
      render json: { status: 'error', errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
end