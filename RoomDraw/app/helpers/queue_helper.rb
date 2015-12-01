module QueueHelper
  include Helper

  def requests
    Request.order(:rank_absolute).find_by_sql req_query current_user.student_id
  end

  def req_query(student_id)
    "
      SELECT requests.*
      FROM requests, members
      WHERE members.student_id = #{student_id}
        AND requests.draw_group_id = members.draw_group_id
    "
  end

end
