module SessionHelper

  def flash_messages
    o = ''
    flash.each do |key, value|
      o += content_tag( :div, value, class: "alert alert-#{key}" )
    end
    o.html_safe
  end

end

