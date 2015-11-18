class Request < ActiveRecord::Base
  has_many :draw_groups, dependent: :delete_all
  has_many :collections, dependent: :delete_all
end
