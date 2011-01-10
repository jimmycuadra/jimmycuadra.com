module ApplicationHelper
  def nav_to(link, path, controller_name)
    content_tag :li, :class => (params[:controller] == controller_name ? "current" : nil) do
      content_tag :div do
        link_to link, path, :class => "awesome"
      end
    end
  end

  def textile(text)
    text.gsub!(/^@@@ ?(\w*)\r?\n(.+?)\r?\n@@@\r?$/m) do |match|
      lang = $1.empty? ? nil : $1
      "\n<notextile>" + CodeRay.scan($2, lang).div(:css => :class) + "</notextile>"
    end

    RedCloth.new(text).to_html.html_safe
  end
end
