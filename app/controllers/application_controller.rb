class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_user!
  before_action :get_tags

  helper_method :is_admin?



  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless is_admin?
    end

    def is_admin?
      user_signed_in? && current_user.admin?
    end

    def get_tags
      @tags = Tag.order(:name)
    end
end
