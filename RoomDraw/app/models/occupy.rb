class Occupy < ActiveRecord::Base

  # define primary key
  self.primary_key = [:student_id, :academic_year, :in_fall?, :in_spring?]

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
