module ApplicationHelper
  def link_to_with_current_indicator(name, options = {}, html_options = {})
    if current_page?(options)
      html_options[:class] ? html_options[:class] += " current" : html_options[:class] += "current"
    end
    link_to(name, options, html_options)
  end
end
