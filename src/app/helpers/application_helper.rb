module ApplicationHelper
  def guest_user?
    current_user.email == 'guest@example.com'
  end

  def body_class
    '#{ controller_name }-#{ action_name }'
  end

  def flash_class(key)
    case key.to_sym
    when :success
      "alert-success"
    when :error
      "alert-danger"
    when :warning
      "alert-danger"
    else
      "alert-primary"
    end
  end
end
