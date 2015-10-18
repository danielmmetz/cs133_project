class Member < ActiveRecord::Base
  # key constraints
  belongs_to :draw_group
  belongs_to :student

  self.primary_keys = :student_id, :draw_group_id
end
