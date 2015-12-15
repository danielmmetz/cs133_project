class Collection < ActiveRecord::Base
  # constraints, also specifying foreign key to Active Record
  has_many :rooms
  has_many :requests
  has_many :occupy
  has_many :draw_groups, through: :occupy
end
