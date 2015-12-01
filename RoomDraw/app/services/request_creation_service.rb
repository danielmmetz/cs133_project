class RequestCreationService

  def initialize
  end

  def create(dg_id, collection_id)
    dg_size = Member.where(draw_group_id: dg_id).count
    collection_size = Room.where(collection_id: collection_id).sum :capacity

    # make sure the group size is equal to collection size
    return if dg_size != collection_size

    # make sure not to re-queue things already in the queue
    unless Request.find_by(collection_id: collection_id, draw_group_id: dg_id).present?
        @new_req = Request.create(collection_id: collection_id, draw_group_id: dg_id)
        return @new_req
    end
  end

  def delete(dg_id, collection_id)
    Request.where(collection_id: collection_id, draw_group_id:
        dg_id).destroy_all
  end

end