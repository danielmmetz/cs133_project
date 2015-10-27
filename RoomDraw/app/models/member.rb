class Member < ActiveRecord::Base
  # key constraints
  belongs_to :draw_group
  belongs_to :student

  # ensure not breaking the Draw Group
  validates_associated :draw_group

  # define composite foreign/primary key
  self.primary_keys = :student_id, :draw_group_id
end
