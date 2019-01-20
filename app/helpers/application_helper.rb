module ApplicationHelper
  def active_by_path(link_path)
    current_page?(link_path) ? 'bg-secondary' : ""
  end

  def active_by_text(text)
    if request.path_info.include?(text)
      "active"
    end
  end

  def flash_class(level)
    case level
      when 'notice' then "alert alert-info alert-shadow alert-dismissible fade show"
      when 'success' then "alert alert-success alert-shadow alert-dismissible fade show"
      when 'error' then "alert alert-danger alert-shadow alert-dismissible fade show"
      when 'alert' then "alert alert-warning alert-shadow alert-dismissible fade show"
    end
  end
end
