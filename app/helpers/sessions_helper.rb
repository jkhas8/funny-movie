module SessionsHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def check_authentication
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end
end
