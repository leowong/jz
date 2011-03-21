module ApplicationHelper
  def link_to_with_current_indicator(name, options = {}, html_options = {})
    if current_page?(options)
      html_options[:class] ? html_options[:class] += " current" : html_options[:class] += "current"
    end
    link_to(name, options, html_options)
  end

  def highlighting_billboard_tab?
    Billboard.all.size > 0 and Billboard.order("created_at").last.created_at.to_date == Time.zone.now.to_date ? true : false
  end

  def wrap(content)
    content = simple_format(h(content))
  end
end
