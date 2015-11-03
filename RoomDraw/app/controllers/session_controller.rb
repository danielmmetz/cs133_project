class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by(student_id: params[:session][:student_id])
    if user && user.authenticate(params[:session][:password])
      current_user
      log_in user
      flash[:success] = "Login Successful"
      redirect_to user
    else
      flash[:warning] = "Incorrect StudentID/Password Combo"
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "Successfully Logged Out"
    redirect_to login_path
  end
end
