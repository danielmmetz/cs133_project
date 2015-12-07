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

  # create a database instance for each member
  def create_members
    @mem_ids.each do |mem_id|
      @members << (Member.create draw_group_id: @draw_group.id, student_id: mem_id)
    end
    true
  end

  def create_draw_group
    @draw_group = DrawGroup.create for_suite: @for_suite, student_id: @rep_id
  end
end