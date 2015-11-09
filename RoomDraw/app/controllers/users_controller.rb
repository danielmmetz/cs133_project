class UsersController < ApplicationController
  def show
    User.find_by student_id: params[:student_id]
  end

  def index
    User.find_by student_id: params[:id]
  end
end
