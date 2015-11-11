module SessionHelper
  include Helper

  def log_in(user)
    session[:student_id] = user.student_id
  end

  def log_out
    session.delete :student_id
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end
end
