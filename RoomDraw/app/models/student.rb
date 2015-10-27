class Student < ActiveRecord::Base
  # constraints
  has_many :members, foreign_key: [:draw_group_id, :student_id]
  has_many :draw_groups
  has_many :rooms, through: :occupy
end
