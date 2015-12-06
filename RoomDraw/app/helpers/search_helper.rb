module SearchHelper

  def results(conds={})
    # initialize the collections to be output
    collections = []
    generator = CollectionDisplayService.new

    # for each collection, check if it satisfies all present conditions
    Collection.all.each do |col|
      collection = generator.retrieve col.id
      valid = true
      if conds.present?
        conds.each do |cond, value|
          valid &= collection[cond.to_sym] == value if value.present?
        end
      end
      # add the collection if it does
      collections.append collection if valid
    end

    # return the collections
    collections
  end

end
