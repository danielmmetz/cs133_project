class Collection < ActiveRecord::Base
  # constraints, also specifying foreign key to Active Record
  has_many :rooms
  has_many :requests
end
