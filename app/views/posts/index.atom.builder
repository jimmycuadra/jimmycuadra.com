xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.atom :link, :href => posts_url(:format => :atom), :rel => "self", :type => "application/rss+xml"
    xml.title "Jimmy Cuadra"
    xml.description "Writing and screencasts on Ruby, JavaScript, HTML, and CSS"
    xml.link posts_url
    xml.language 'en'
    xml.pubDate @posts.first.created_at.to_s(:rfc822)
    xml.lastBuildDate @posts.first.created_at.to_s(:rfc822)

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description markdown(post.body)
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end
