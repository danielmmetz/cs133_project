class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by(student_id: params[:session][:student_id])
    if user && user.authenticate(params[:session][:password])
      log_in user
    else
      render 'new'
    end
  end

  def destroy
  end
end
