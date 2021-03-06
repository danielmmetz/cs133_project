class DrawGroup < ActiveRecord::Base
  # key constraints
  has_many :members, foreign_key: [:draw_group_id, :student_id], dependent: :delete_all
  has_many :requests
  has_many :draw_groups, through: :occupy
  belongs_to :student

  self.primary_key = :id

  ## Assign the representitive if none has been assigned
  def calibrate
    self.update_attributes draw_num: calculate_draw_num, student_id: assign_representative, for_suite: detect_suite
  end

  def min_suite
    3
  end

  def max_suite
    6
  end

  private

  ## Call this method on creation if student is empty
  ## Selects the member with the highest draw number
  ## Must be called after the creation of the membership relations
  def assign_representative
    # access the members in the has_many relation
    @student = Student.find(members.first.student_id)
    @members.each do |m|
      @student = m.student if m.student.draw_num < @student.draw_num
    end
    @student.id
  end

  ## This method calculates the draw number of the Draw Group
  ## Must be called after the creation of the membership relations
  def calculate_draw_num
    ## If it is a suite, calculate the average as a real
    if detect_suite then
      sum = 0.0
      count = 0.0
      members.each do |m|
        sum += m.student.draw_num - 10000.0
        count += 1.0
      end
      sum / count
    else
      min = 100000000   # pick a sufficiently large number

      # find the minimum draw num
      members.each do |m|
        min = m.student.draw_num if m.student.draw_num < min
      end
      min
    end
  end

  def detect_suite
    return if members.nil?
    @for_suite ||= @members.length > 2
  end


  def members
    @members = Member.where(draw_group_id: self.id)
  end
end
