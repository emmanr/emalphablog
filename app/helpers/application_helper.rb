module ApplicationHelper

  def active_links(link_text, link_path)
    link_to link_text, link_path, class: "#{'active' if current_page?(link_path)}"
  end

end
