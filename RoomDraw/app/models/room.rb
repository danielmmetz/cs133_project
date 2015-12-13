class Room < ActiveRecord::Base
  #constraints
  belongs_to :collection
  has_many :occupy
  has_many :students, through: :occupy

end