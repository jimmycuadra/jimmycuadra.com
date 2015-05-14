Encoding.default_external = Encoding.default_internal = Encoding::UTF_8

task :middleman => :environment do
  Post.all.each do |post|
    File.open(File.join('middleman', post.slug) + '.html.md', 'w') do |file|
      file.write <<-EOF
---
title: "#{post.title}"
date: "#{post.created_at.strftime("%Y-%m-%d %H:%M %Z")}"
tags: "#{post.tags.map { |tag| tag.name }.sort.join(", ")}"#{"\nyoutube_id: \"" + post.youtube_id + '"' if post.youtube_id.size > 0}
---
#{post.body.gsub(/`{3}/, '~~~').chomp.encode(universal_newline: true)}
EOF
    end
  end
end
