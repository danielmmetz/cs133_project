module SearchHelper

  def results(conds={})
    # initialize the collections to be output
    collections = []
    generator = CollectionDisplayService.new

    # for each collection, check if it satisfies all present conditions
    Collection.includes(:rooms).find_each do |col|
      collection = generator.retrieve col.rooms, col.id
      valid = true
      if conds.present?
        conds.each do |cond, value|
          valid &= collection[cond.to_sym].to_s == value if value.present?
        end
      end
      # add the collection if it does
      collections.append collection if valid
    end

    # return the collections
    collections
  end

end
