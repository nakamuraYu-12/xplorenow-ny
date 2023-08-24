class ApplicationController < ActionController::Base
  # before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # 各Controllerで使用できそうなので用意しておくと記述量が格段に減りそうです！
  
  # set_current_user
  #   @user = current_user
  # end
end
