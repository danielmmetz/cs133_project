class Occupy < ActiveRecord::Base
  self.primary_key = [:student_id, :dorm_name, :room_num]
end
