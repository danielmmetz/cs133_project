module GroupsHelper
  include SessionHelper

  def draw_groups
    DrawGroup.where student_id: current_user.student_id
  end

  def students_in(draw_group)
    Student.find_by_sql students_query draw_group
  end

  private

  # a query that gets the students in a particular draw_group
  def students_query(draw_group)
    "
    SELECT students.*
    FROM members, students
    WHERE members.student_id = students.id
      AND members.draw_group_id = #{draw_group.id}
    "
  end
end
