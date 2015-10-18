class Student < ActiveRecord::Base
  # constraints
  has_many :members, foreign_key: [:draw_group_id, :student_id]
  has_many :rep_groups, class_name: 'DrawGroup'
  has_many :rooms, through: :occupy
end
