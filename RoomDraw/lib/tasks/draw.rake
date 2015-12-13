namespace :draw do
  desc "Perform the automated draw"
  task :auto, [:year] => :environment do |t, args|
    draw_order = Request.order :rank_absolute
    draw_order.each do |r|
      break if all_drawn? args[:year]
      unless any_has_room? r, args[:year]
        draw_room r, args[:year]
      end
    end
  end
end

def all_drawn?(year)
  (Occupy.where academic_year: year).count ==
    Student.where("grad_year > #{year} AND NOT is_absent").count
end

def draw_room(request, year)
  members = Member.where draw_group_id: request.draw_group_id
  rooms = Room.where collection_id: request.collection_id
  return if members.length != rooms.length
  rooms.each_with_index do |r,i|
    Occupy.create(
      student_id: members[i].student_id,
      room_id: r.id,
      dorm_name: r.dorm_name,
      room_num: r.room_num,
      academic_year: year,
      in_fall?: true,
      in_spring?: true
    )
  end
end

def any_has_room?(request, year)
  # identify if any member already has a room assignment
  members = Member.where draw_group_id: request.draw_group_id
  members.each do |mem|
    if (Occupy.where student_id: mem.student_id, academic_year: year).count > 0
      return true
    end
  end
  return false
end
