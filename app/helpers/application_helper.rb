module ApplicationHelper
  def textile(text)
    text.gsub!(/^@@@ ?(\w*)\r?\n(.+?)\r?\n@@@\r?$/m) do |match|
      lang = $1.empty? ? nil : $1
      "\n<notextile>" + $2 + "</notextile>"
    end

    RedCloth.new(text).to_html.html_safe
  end
end
