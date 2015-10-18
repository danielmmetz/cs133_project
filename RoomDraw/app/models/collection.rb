class Collection < ActiveRecord::Base
  # constraints, also specifying foreign key to Active Record
  has_many :rooms, foreign_key: [:dorm_name, :room_num]
  has_and_belongs_to_many :requests
end
