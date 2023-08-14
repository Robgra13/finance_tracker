class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :fetch_tracked_stocks, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  private

  def fetch_tracked_stocks
    @tracked_stocks = current_user.stocks
  end
end
