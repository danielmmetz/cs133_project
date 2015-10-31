# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# want 8 char student ids; for simplicty 10000001 10000002
# for simplicity, lets make passwords just pass1, pass2, pass3

students = %w(10000001 10000002 10000003)
passwords = %w(pass1 pass2 pass3)
combination = students.zip passwords

combination.each do |student_id, password|
  User.create(
    student_id: student_id,
    password: password,
    password_confirmation: password
  )
end

