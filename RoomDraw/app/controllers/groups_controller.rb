class GroupsController < ApplicationController
  def show
  end

  def index
  end

  def create
    generator.call
    redirect_to group_path
  end

  def destroy
    flash[:error] = "DESTROY -- destroy"
    generator.delete params[:group_id]
    render :show
  end

  private

  def generator
    DrawGroupCreationService.new rep_id: current_user.student_id, suite?: false, mem_ids: [current_user.student_id]
  end
end
