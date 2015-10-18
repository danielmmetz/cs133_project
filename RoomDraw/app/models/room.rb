class Room < ActiveRecord::Base
  #constraints
  belongs_to :collection

  self.primary_keys = :dorm_name, :room_num
end
