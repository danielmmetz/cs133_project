class DrawGroupCreationService

  # will create a draw group for the members.
  # members is an array of ids of those in the group
  def initialize (options)
    @rep_id = options[:rep_id] or nil
    @for_suite = options[:suite?] or false
    @mem_ids = options[:mem_ids]
    @members = []
  end

  ## returns false if the creation of the draw group fails
  def call
    rollback and return unless create_draw_group
    puts @draw_group
    create_members
    calibrate_draw_group
  end

  def delete (id)
    (DrawGroup.find id).destroy
  end

  def calibrate_draw_group
    @draw_group.calibrate
  end

  private

  def rollback
    @draw_group.destroy unless @draw_group.nil?
    @members.each{|mem| mem.destroy}
    true
  end

  # if there are a valid number of members, create a database instance for each
  def create_members
    return unless valid_num_members?
    @mem_ids.each do |mem_id|
      @members << (Member.create draw_group_id: @draw_group.id, student_id: mem_id)
    end
    true
  end

  # return true if the number of members is between 06 and greater than 3 if a
  # suite, and less than three otherwise
  def valid_num_members?
    num = @mem_ids.count
    num <= @draw_group.max_suite and num > 0 and            # not to many people
      ((not @for_suite and num < @draw_group.min_suite) or # not too many for double
        (@for_suite and num >= @draw_group.min_suite))     # not too few for suite
  end

  def create_draw_group
    @draw_group = DrawGroup.create for_suite: @for_suite, student_id: @rep_id
  end
end