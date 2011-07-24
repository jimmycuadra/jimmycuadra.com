module CommentsHelper
  def format_comment(comment)
    comment = h(comment).to_str # escape user input
    comment.gsub!("\r", "") # strip \r
    comment.gsub!("\n\n", "</p><p>") # split paragraphs
    comment.gsub!("<p></p>", "") # remove empty paragraphs
    comment.gsub!(/\n(?=.)/, "<br />") # add breaks
    comment.chop! if comment[-1] == "\n" # strip trailing newline
    "<p>#{auto_link_urls(comment)}</p>".html_safe
  end
end
