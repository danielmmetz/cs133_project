module GroupsHelper
  include SessionHelper

  def draw_groups
    DrawGroup.where student_id: current_user.student_id
  end
end
