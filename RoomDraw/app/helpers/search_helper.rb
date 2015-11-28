module SearchHelper

  def results(conds={})
    if conds.present? and conds[:dorm_name].present?
      Room.where conds.symbolize_keys
    else
      Room.all
    end
  end
end
