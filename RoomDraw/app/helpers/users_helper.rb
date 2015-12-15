module UsersHelper
  include Helper

  def dorm_name(occ)
    occ.collection.rooms.first.dorm_name
  end

  def room_nums(occ)
    occ.collection.rooms.map{|r| r.room_num }.join(", ")
  end

  def group_names(occ)
    (group_members occ).map{|m| m.student.name }.join(", ")
  end

  def group_members(occ)
    Member.where draw_group_id: occ.draw_group
  end

  # Get the collection into which the student has drawn
  # Get another room in that collection.
  # get the student in that room
  def occupy_query(sid)
    dg_ids = (Member.where student_id: sid).pluck :draw_group_id
    dg_ids.each do |dg|
      occ = Occupy.includes(:collection).where draw_group_id: dg, academic_year: draw_year
      return occ.first if occ.present?
    end
    return
  end

  def draw_year
      Date.today.year.to_i
  end

  def curr_month
    Date.today.month.to_i
  end

  def curr_name
    (Student.find current_user.student_id).name
  end
end
