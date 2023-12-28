class ConfirmationsController < Devise::ConfirmationsController
    protected

    def after_confirmation_path_for(resource_name, resource)
        'localhost:3000/'
    end
end