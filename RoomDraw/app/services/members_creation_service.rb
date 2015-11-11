class MembersCreationService

  def initialize
  end

  def create(draw_group, student_id)
    return false unless can_add_member_to draw_group, student_id
    m = Member.create draw_group_id: draw_group.id, student_id: student_id
    draw_group.callibrate
    draw_group.save
    return m
  end

  def delete(draw_group, student_id)
    mem = Member.where(draw_group_id: draw_group.id, student_id: student_id).first
    mem.destroy if mem.present?
    draw_group.callibrate
  end

  def can_add_member_to(draw_group, student_id)
    group_not_full(draw_group) and
    not already_in(draw_group, student_id) and
    not too_many_groups student_id
  end

  def draw_group_size(draw_group)
    Member.where(draw_group_id: draw_group.id).count
  end

  def group_not_full(draw_group)
    num = draw_group_size draw_group
    num <= draw_group.max_suite and num > 0 and                     # not to many people
      ((not draw_group.for_suite and num < draw_group.min_suite) or # not too many for double
        (draw_group.for_suite and num >= draw_group.min_suite))     # not too few for suite
   end

  def already_in(draw_group, student_id)
    Member.where(draw_group_id: draw_group.id, student_id: student_id).present?
  end

  def too_many_groups(student_id)
    Member.where(student_id: student_id).count >= 50
  end
end