class OccupyCreationService

  def initialize
  end

  def draw(request, year)
    # assume draw groups can only make requests for collections of capacity equal
    # to the groups' size
    if valid_request? request, year
      Occupy.create(
        draw_group_id: request.draw_group_id,
        collection_id: request.collection_id,
        academic_year: year,
        in_fall?: true,
        in_spring?: true
      )
   end
  end

  def valid_request?(request, year)
    return unless has_collection? request, year
    # identify if any members in the draw group have already been assigned to a collection
    mem_ids = (Member.where draw_group_id: request.draw_group_id).pluck :student_id
    mem_ids.each do |m|
      dg_ids = (Member.where student_id: m).pluck :draw_group_id
      dg_ids.each do |dg|
        if (Occupy.where draw_group_id: dg, academic_year: year).present?
          return false
        end
      end
    end
    return true
  end

  def has_collection?(request, year)
    # identify if the draw group already has a collection assignment
    Occupy.where draw_group_id: request.draw_group_id, academic_year: year
  end

end