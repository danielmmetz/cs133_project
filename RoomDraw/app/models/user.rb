class User < ActiveRecord::Base
  validates :student_id, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_secure_password
end
