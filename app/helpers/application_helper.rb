module ApplicationHelper
  def nav_to(link, path, controller_name)
    content_tag :li, :class => (params[:controller] == controller_name ? "current" : nil) do
      content_tag :div do
        link_to link, path, :class => "awesome"
      end
    end
  end

  def markdown(text)
    options = [:autolink, :fenced_code, :hard_wrap, :no_intraemphasis, :xhtml]
    html = Redcarpet.new(text, *options).to_html

    doc = Nokogiri::HTML(html)
    doc.css("pre").each do |pre|
      codeblock = pre.children.first
      lang = codeblock[:class]
      lang = nil if lang.empty?
      pre.replace CodeRay.scan(codeblock.text, lang).div(:css => :class)
    end

    doc.to_s.html_safe
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
