class Request < ActiveRecord::Base
  has_many :draw_groups
  has_many :collections
end
