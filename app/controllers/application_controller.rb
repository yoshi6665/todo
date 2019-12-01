class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||=User.find_by(id:session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate_user
    if current_user == nil
      redirect_to("/login")
    end
  end
end
