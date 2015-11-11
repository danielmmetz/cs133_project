class GroupsController < ApplicationController
  def show
  end

  def index
  end

  def create
    puts params
    if params[:action] == :destroy or params[:group_id].present?
      flash[:error] = "DESTROY"
      generator.delete params[:group_id]
      redirect_to group_path
    else
      generator.call
      redirect_to group_path
    end
  end

  def destroy
    flash[:error] = "DESTROY"
    generator.delete params[:group_id]
    render :show
  end

  private

  def generator
    DrawGroupCreationService.new rep_id: current_user.student_id, suite?: false, mem_ids: [current_user.student_id]
  end
end
