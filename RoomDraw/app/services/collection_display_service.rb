class CollectionDisplayService

  def initialize
  end

  def retrieve(col_id)
    r = Room.where collection_id: col_id
    {
      id: col_id,
      rooms: r,
      capacity: (r.sum :capacity),
      dorm_name: r.first[:dorm_name],
      num_rooms: r.size,
      room_nums: (r.pluck :room_num).sort,
      room_capacities: (r.pluck :capacity).sort
    }
  end

end
