FactoryGirl.define do
  factory :post do
    title "Blog post title"
    body "This is a blog post about something"
  end

  factory :comment do
    name "Bongo"
    email "bongo@example.com"
    url "http://example.com"
    comment "Great post!"
    post
  end
end
