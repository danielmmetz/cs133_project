module SessionHelper

  def log_in(user)
    session[:student_id] = user.student_id
  end

  def log_out
    session.delete :student_id
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by student_id: session[:student_id]
  end

  def logged_in?
    !current_user.nil?
  end
end
