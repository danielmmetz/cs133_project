class Room < ActiveRecord::Base
  #constraints
  belongs_to :collection
end
