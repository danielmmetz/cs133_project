class GroupsController < ApplicationController
  def show
  end

  def index
    redirect_to group_path(id: current_user.student_id)
  end

  def create
    if params[:commit] == "New Group"
      if member_generator.too_many_groups params[:id]
        flash[:error] = "You are already in the maximum number of groups allowed"
      else
        draw_group_generator.call
      end
      redirect_to group_path
    elsif params[:commit] == "Add"
      dg = (draw_group params[:member][:group_id])
      stud_id = params[:member][:student]
      if (Student.where id: stud_id).length > 0
        puts dg, stud_id
        if member_generator.create dg, stud_id
          flash[:notice] = "Student #{params[:member][:student]} Added"
        else
          flash[:error] = "Group is full, student is in too many groups, or
          student is already in the group"
        end
      else
        flash[:warning] = "Provided student id does not exist, please try
        again."
      end
      render :show
    end
  end

  def destroy
    flash[:error] = "Group has been removed."
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
