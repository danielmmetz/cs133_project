class Member < ActiveRecord::Base
  # key constraints
  belongs_to :draw_group
  belongs_to :student

  # ensure not breaking the Draw Group
  validates_associated :draw_group

  # define composite foreign/primary key
  self.primary_keys = :student_id, :draw_group_id

  after_commit :delete_group_requests

  def delete_group_requests
    (Request.where draw_group_id: self.draw_group_id).destroy_all
  end
end
