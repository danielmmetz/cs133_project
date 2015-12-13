namespace :draw do
  desc "Perform the automated draw"
  task :auto, [:year] => :environment do |t, args|
    draw_order = Request.order :rank_absolute
    draw_order.each do |r|
      break if all_drawn? args[:year]
      draw_room r, args[:year]
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
      academic_year: year,
      in_fall?: true,
      in_spring?: true
    )
  end
end
