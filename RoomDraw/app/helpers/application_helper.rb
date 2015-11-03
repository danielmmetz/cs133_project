module ApplicationHelper

  def bootstrap_class_for (flash_type)
    {
      success: "alert-success",
      error:   "alert-danger",
      warning: "alert-warning",
      notice:  "alert-info"
    }.fetch(flash_type.to_sym, flash_type.to_s)
  end
end
