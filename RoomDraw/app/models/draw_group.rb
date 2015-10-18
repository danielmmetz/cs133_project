class DrawGroup < ActiveRecord::Base
  # key constraints
  has_many :members, foreign_key: [:draw_group_id, :student_id]
  has_and_belongs_to_many :requests
  has_one :student
end
