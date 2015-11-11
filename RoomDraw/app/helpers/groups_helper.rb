module GroupsHelper
  include Helper

  def draw_groups
    DrawGroup.find_by_sql draw_group_query current_user.student_id
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

  def draw_group_query(student_id)
    "
      SELECT draw_groups.*
      FROM draw_groups, members
      WHERE members.student_id = #{student_id}
        AND members.draw_group_id = draw_groups.id
    "
  end
end
