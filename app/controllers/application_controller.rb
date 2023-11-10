class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied, with: :not_authorized

  def not_authorized
    redirect_to new_user_session_path, alert: 'You have to login to perform this action.'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio photo posts_counter])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio photo])
  end
end
