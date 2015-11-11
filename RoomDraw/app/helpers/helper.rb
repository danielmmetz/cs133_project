module Helper

  def current_user
    @current_user ||= User.find_by student_id: session[:student_id]
  end

end