module ApplicationHelper
  def active_by_path(link_path)
    current_page?(link_path) ? 'active' : ""
  end

  def active_by_text(text)
    if request.path_info.include?(text)
      "active"
    end
  end
end
