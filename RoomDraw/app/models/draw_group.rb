class DrawGroup < ActiveRecord::Base
  # key constraints
  has_many :members, foreign_key: [:draw_group_id, :student_id]
  has_one :student
end
