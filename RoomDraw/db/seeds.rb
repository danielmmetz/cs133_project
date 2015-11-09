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


