class CollectionDisplayService

  def initialize
  end

  def retrieve(rooms)
    get_capacities rooms
    get_nums rooms

    return {
      id: rooms.first.collection_id,
      rooms: rooms,
      capacity: (total_capacity @caps),
      dorm_name: rooms.first[:dorm_name],
      num_rooms: rooms.length,
      room_nums: @nums,
      room_capacities: @caps
    }
  end

  def get_nums(rooms)
    @nums = []
    rooms.each{|r| @nums << r.room_num}
    return @nums
  end

  def get_capacities(rooms)
    @caps = []
    rooms.each{|r| @caps << r.capacity}
    return @caps
  end

  def total_capacity(caps)
    caps.inject{|sum, x| sum + x}
  end

end
