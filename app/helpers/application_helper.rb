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
    content = auto_link_order_number(content)
    content = auto_link(content)
  end

  def wrap_task_name(name)
    name = auto_link_order_number(name)
    name = auto_link(name)
    raw name
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  private

  def auto_link_order_number(name)
    name.gsub! /#[0-9a-f]{7}/i do |match|
      Order.find_by_number(number = match[1..-1]) ? link_to(match, order_path(:id => number)) : match
    end
    raw name
  end
end
