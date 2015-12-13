module UsersHelper
  include Helper

  def student_room(sid)
    Room.find_by_sql(query(sid)).first # only one result will be returned
  end

  def groupmates(sid)
    prettify ActiveRecord::Base.connection.execute group_query(sid)
  end

  def prettify (pg_names)
    if pg_names.count < 1
      "You are in a single"
    else
      "You are living with #{pg_names.values.join(", ")}!"
    end
  end

  # Get the collection into which the student has drawn
  # Get another room in that collection.
  # get the student in that room
  def group_query(sid)
    "SELECT S2.name
     FROM Occupies as O, Rooms as R, Students as S2, Rooms as R2, Occupies as O2
     WHERE R.id = O.room_id AND O.student_id = #{sid}
        AND O.academic_year = #{draw_year} AND #{sem_string "O"}
        AND R.collection_id = R2.collection_id
        AND O2.room_id = R2.id AND S2.id = O2.student_id
        AND O2.academic_year = #{draw_year} AND #{sem_string "O2"}
        AND NOT S2.name = '#{curr_name}';
     "
  end

  def query(sid)
    "SELECT rooms.*
      FROM rooms, occupies
      WHERE rooms.id = occupies.room_id AND occupies.student_id = #{sid}
        AND academic_year = #{draw_year} AND #{sem_string "occupies"};"
  end

  def sem_string(o)
    curr_month <= 6 ? "#{o}.\"in_fall?\" = TRUE;" : "#{o}.\"in_spring?\" = TRUE"
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

  def curr_name
    (Student.find current_user.student_id).name
  end
end
