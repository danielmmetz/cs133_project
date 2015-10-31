module SessionHelper

  def log_in(user)
    session[:student_id] = user.student_id
  end
end
