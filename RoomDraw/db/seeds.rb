# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



1.upto(30).each{|i|
  User.create student_id: 100+i, password: "pass#{i}", password_confirmation: "pass#{i}"
  StudentCreationService.new id:100+i, name: "Jim#{i} Turner#{i}", draw_num: i, grad_year: 2017
}

1.upto(5).each do |i|
  Collection.create id: i, suite_num: i
end

1.upto(5).each do |i|
  Room.create dorm_name: "clk#{i}", room_num: i, capacity: i%2+1, collection_id: i
end

Room.create dorm_name: "clk3", room_num: 6, capacity: 1, collection_id: 3

(DrawGroupCreationService.new mem_ids: [101, 102]).call

Request.create draw_group_id: 1, collection_id: 1, rank_absolute: 1
Request.create draw_group_id: 31, collection_id: 2, rank_absolute: 2
