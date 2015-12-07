# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'set'

###############################################################################################################
# create students
###############################################################################################################
puts "CREATING STUDENTS at #{Time.now}"

NUM_STUDENTS = 1700

scs_gen = StudentCreationService.new
1.upto(NUM_STUDENTS).each do |i|
  User.create student_id: i, password: "#{i}",  password_confirmation: "#{i}"
  scs_gen.create id: i, name: "Casey#{i} Smith#{i}", draw_num: i, grad_year: 2017+i/430
end

###############################################################################################################
# create collections. 770 comes from the number of collections per dorm (55) times the number of dorms (14)
###############################################################################################################
puts "CREATING COLLECTIONS at #{Time.now}"

NUM_COLLECTIONS = 770
1.upto(NUM_COLLECTIONS).each do |i|
    Collection.create id: i, suite_num: i
end

# ###############################################################################################################
# # create rooms
# ###############################################################################################################
puts "CREATING ROOMS at #{Time.now}"

dorm_names = [
  "CLK1",
  "CLK3",
  "CLK5",
  "WLKR",
  "POM",
  "SNTG",
  "LWRY",
  "MUDD",
  "BLSD",
  "HRWD",
  "GIBS",
  "LYON",
  "WIG",
  "SMLY"
]

col_1 = Set.new []
col_2 = Set.new []
col_4 = Set.new []
col_5 = Set.new []
col_6 = Set.new []

collection_to_assign = 1
dorm_names.each_with_index do |dname, index|
  # 10 singles
  1.upto(10).each do |rnum|
    Room.create dorm_name: dname, room_num: rnum, capacity: 1, collection_id: collection_to_assign
    col_1.add collection_to_assign
    collection_to_assign += 1
  end

  # 15 1-room doubles
  11.upto(25).each do |rnum|
    Room.create dorm_name: dname, room_num: rnum, capacity: 2, collection_id: collection_to_assign
    col_2.add collection_to_assign
    collection_to_assign += 1
  end

  # 15 2-room doubles
  26.upto(40).each do |rnum|
    Room.create dorm_name: dname, room_num: rnum, capacity: 1, collection_id: collection_to_assign
    col_2.add collection_to_assign
    collection_to_assign += 1 if (rnum+1)%2 == 0 #increment only every 2nd time
  end

  # 5 4-person suites (2 doubles) => 10 rooms
  41.upto(50).each do |rnum|
    Room.create dorm_name: dname, room_num: rnum, capacity: 2, collection_id: collection_to_assign
    col_4.add collection_to_assign
    collection_to_assign += 1 if rnum%2 == 0 #increment only every 2nd time
  end

  # 5 4-person suites (1 double, 2 singles) => 15 rooms
  51.upto(65).each do |rnum|
    cap = rnum%3 > 0 ? 2 : 1
    Room.create dorm_name: dname, room_num: rnum, capacity: cap, collection_id: collection_to_assign
    col_4.add collection_to_assign
    collection_to_assign += 1 if (rnum+1)%3 == 0 #increment only every 3rd time
  end

  # 5 4-person suites (4 singles) => 20 rooms
  66.upto(85).each do |rnum|
    Room.create dorm_name: dname, room_num: rnum, capacity: 1, collection_id: collection_to_assign
    col_4.add collection_to_assign
    collection_to_assign += 1 if (rnum+3)%4 == 0 #increment only every 4th time
  end

  # 3 5-person suites (2 doubles, 1 single) => 9 rooms
  86.upto(94).each do |rnum|
    cap = rnum%3 > 0 ? 1 : 2
    Room.create dorm_name: dname, room_num: rnum, capacity: cap, collection_id: collection_to_assign
    col_5.add collection_to_assign
    collection_to_assign += 1 if (rnum+2)%3 == 0 #increment only every 3rd time
  end

  # 5 6-person suites (6 singles) => 30 rooms
  95.upto(124).each do |rnum|
    Room.create dorm_name: dname, room_num: rnum, capacity: 1, collection_id: collection_to_assign
    col_6.add collection_to_assign
    collection_to_assign += 1 if (rnum+2)%6 == 0 #increment only every 4th time
  end
end

###############################################################################################################
# create groups
###############################################################################################################
puts "CREATING GROUPS at #{Time.now}"

STUDENT_IDS = 1.upto(NUM_STUDENTS).to_a

dg_1 = Set.new 1.upto(NUM_STUDENTS).to_a
dg_2 = Set.new []
dg_4 = Set.new []
dg_5 = Set.new []
dg_6 = Set.new []

dg_num = NUM_STUDENTS + 1

# create 200 groups of size 2
1.upto(200).each do
  (DrawGroupCreationService.new mem_ids: (STUDENT_IDS.sample 2)).call
  dg_2.add dg_num
  dg_num += 1
end

# create 100 groups of size 4
1.upto(100).each do
  (DrawGroupCreationService.new mem_ids: (STUDENT_IDS.sample 4)).call
  dg_4.add dg_num
  dg_num += 1
end

# create 50 groups of size 5
1.upto(50).each do
  (DrawGroupCreationService.new mem_ids: (STUDENT_IDS.sample 5)).call
  dg_5.add dg_num
  dg_num += 1
end

# create 40 groups of size 6
1.upto(40).each do
  (DrawGroupCreationService.new mem_ids: (STUDENT_IDS.sample 6)).call
  dg_6.add dg_num
  dg_num += 1
end

###############################################################################################################
# create requests
###############################################################################################################
puts "CREATING REQUESTS at #{Time.now}"
rcs_gen = RequestCreationService.new

dgs = [dg_1, dg_2, dg_4, dg_5, dg_6]
cols = [col_1, col_2, col_4, col_5, col_6]
dg_col = dgs.zip(cols)

dg_col.each do |dg, col|
  1.upto(1000).each do
    rcs_gen.create dg.to_a.sample, col.to_a.sample
  end
end

puts "FINISHED at #{Time.now}"
