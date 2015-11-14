class GroupsController < ApplicationController
  def show
  end

  def index
    redirect_to group_path(id: current_user.student_id)
  end

  def create
    if params[:commit] == "New Group"
      draw_group_generator.call
      redirect_to group_path
    elsif params[:commit] == "Add"
      dg = (draw_group params[:member][:group_id])
      stud_id = params[:member][:student]
      puts dg, stud_id
      if member_generator.create dg, stud_id
        flash[:notice] = "Student #{params[:member][:student]} Added"
      else
        flash[:warning] = "Group is full, student is in too many groups, or student is already in the group"
      end
      render :show
    end
  end

  def destroy
    flash[:error] = "DESTROY -- destroy"
    draw_group_generator.delete params[:group_id]
    render :show
  end

  private

  def draw_group(gid)
    DrawGroup.find gid
  end

  def draw_group_generator
    DrawGroupCreationService.new rep_id: current_user.student_id, suite?: false, mem_ids: [current_user.student_id]
  end

  def member_generator
    MembersCreationService.new
  end
end
