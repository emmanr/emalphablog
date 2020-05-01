module ApplicationHelper

  def active_links(link_text, link_path, extra_class)
    link_to link_text, link_path, class: "#{'active' if current_page?(link_path)} #{extra_class}"
  end

  def user_thumbnail(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatr_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatr_url, alt: user.username, class: "user-thumbnail")
  end

end
