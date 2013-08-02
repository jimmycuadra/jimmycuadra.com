module ApplicationHelper
  def nav_for(name, path, options = {})
    link_to_unless_current(name, path, options) do
      content_tag(:span) { name }
    end
  end

  def markdown(text, options = {})
    JimmyCuadra::Markdown.render(text, options)
  end
end
