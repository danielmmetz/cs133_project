module OccupyHelper
  def student_room(sid)
    Room.find_by_sql(query(sid)).first
  end

  def query(sid)
    q = "SELECT rooms.*
        FROM rooms, occupies
        WHERE rooms.id = occupies.room_id AND occupies.student_id = #{sid}
          AND academic_year = #{draw_year} AND "
    q += sem_string
  end

  def sem_string
    curr_month <= 6 ? '"in_fall?" = TRUE;' : '"in_spring?" = TRUE;'
  end

  def draw_year
    if curr_month <= 6
      Date.today.year.to_i
    else
      Date.today.year.to_i + 1
    end
  end

  def curr_month
    Date.today.month.to_i
  end
end
