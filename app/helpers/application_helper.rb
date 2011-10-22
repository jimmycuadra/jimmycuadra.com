module ApplicationHelper
  def nav_for(name, path, options = {})
    link_to_unless_current(name, path, options) do
      content_tag(:span) { name }
    end
  end

  def markdown(text, *args)
    options = args.extract_options!
    md_options = [:autolink, :fenced_code, :hard_wrap, :no_intraemphasis, :xhtml]
    md_options.concat [:filter_html, :filter_styles, :safelink] if options[:safe]

    html = Redcarpet.new(text, *md_options).to_html

    doc = Nokogiri::HTML(html)
    doc.css("pre").each do |pre|
      codeblock = pre.children.first
      lang = codeblock[:class]
      pre.replace CodeRay.scan(codeblock.text, lang).div(:css => :class)
    end

    doc.to_s.html_safe
  end
end
