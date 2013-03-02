module CapybaraHelper
  def login!
    visit login_path
    fill_in "Password", with: ENV["ADMIN_PASSWORD"]
    click_button "Log in"
  end

  def logout!
    click_on "Log out"
  end
end
