require "spec_helper"

feature "Posting comments" do
  let(:post) { FactoryGirl.create :post }
  let(:comment_body) do
    <<-COMMENT
This blog totally sucks because you are:

* an idiot
* a moron
* a fool

If you were a real man, you'd write awesome code like this:

``` ruby
def lololol(lmao)
  lmao.to_s
end
```
    COMMENT
  end

  scenario "adding a comment" do
    visit post_path(post)
    fill_in "Name", with: "Bongo"
    fill_in "Email", with: "bongo@example.com"
    fill_in "URL", with: "example.com"
    fill_in "Comment", with: comment_body
    click_on "Add comment"
    page.should have_content("Bongo commented")
    page.should have_content("This blog totally sucks")
  end
end
