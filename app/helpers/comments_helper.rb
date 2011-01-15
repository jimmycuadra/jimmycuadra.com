module CommentsHelper
  def format_comment(comment)
    comment = h(comment) # escape user input
    comment.gsub!("\n\n", "</p><p>") # split paragraphs
    comment.gsub!("<p></p>", "") # remove empty paragraphs
    comment.gsub!(/\n(?=.)/, "<br />") # add breaks
    comment.chop! if comment[-1] == "\n" # strip trailing newline
    "<p>#{auto_link_urls(comment)}</p>".html_safe
  end
end
