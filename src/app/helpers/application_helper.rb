module ApplicationHelper
  def guest_user?
    current_user.email == 'guest@example.com'
  end
  def body_class
    controller_name + "-" + action_name
  end

end

