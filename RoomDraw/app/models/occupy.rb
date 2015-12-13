class Occupy < ActiveRecord::Base
  belongs_to :room
  belongs_to :student

  # define primary key
  self.primary_key = [:student_id, :dorm_name, :room_num]

  # define validations
  validate { fall_or_spring? }
  validates :academic_year, presence: true

  private

  def fall_or_spring?
    unless in_fall? or in_spring?
      errors.add :base, "Student must occupy a room at least one semester a year"
    end
  end

end
