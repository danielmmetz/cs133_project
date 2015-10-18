class Room < ActiveRecord::Base
  #constraints
  belongs_to :collection
  has_many :students, through: :occupy

  self.primary_keys = :dorm_name, :room_num
end
