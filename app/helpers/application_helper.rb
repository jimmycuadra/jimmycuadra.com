module ApplicationHelper
  def nav_to(link, path, controller_name)
    content_tag :li, :class => (params[:controller] == controller_name ? "current" : nil) do
      content_tag :div do
        link_to link, path, :class => "awesome"
      end
    end
  end

  def markdown(text)
    Redcarpet.new(text, :autolink, :fenced_code, :hard_wrap, :no_intraemphasis, :xhtml).to_html.html_safe
  end

  def format_comment(text)
    options = [
      :autolink,
      :fenced_code,
      :filter_html,
      :filter_styles,
      :gh_blockcode,
      :hard_wrap,
      :no_intraemphasis,
      :safelink,
      :xhtml
    ]

    Redcarpet.new(text, *options).to_html.html_safe
  end
end
