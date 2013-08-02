require "spec_helper"

feature "Post publishing" do
  context "as an admin" do
    background do
      login!
    end

    scenario "saving a new post without publishing it" do
      visit new_post_path
      fill_in "Title", with: "Unpublished post"
      fill_in "Body", with: "Only the admin can see this for now!"
      click_on "Create Post"
      expect(page).to have_selector(".unpublished")
      logout!
      expect(page).not_to have_content("Only the admin can see this for now!")
    end

    scenario "saving a new post and publishing it" do
      visit new_post_path
      fill_in "Title", with: "Published post"
      fill_in "Body", with: "Everyone can see this!"
      check "Publish"
      click_on "Create Post"
      expect(page).to have_content("Everyone can see this!")
      logout!
      expect(page).to have_content("Everyone can see this!")
      find("a", text: "Published post").click
      expect(page).to have_content("Everyone can see this!")
    end
  end
end
