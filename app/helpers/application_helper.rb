module ApplicationHelper

  def error_messages_for(object)
    o = ''
    if object.errors.any?
      o = "<ul>"
      object.errors.full_messages.each do |msg|
        o += content_tag(:li, msg)
      end
      o += "</ul>"
    end
    o.html_safe
  end

end

