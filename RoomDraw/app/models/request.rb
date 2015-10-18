class Request < ActiveRecord::Base
  has_and_belongs_to_many :draw_groups
  has_and_belongs_to_many :collections
end
