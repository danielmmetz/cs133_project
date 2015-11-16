module SearchHelper

  def results(conds={})
    Room.where conds
  end
end
