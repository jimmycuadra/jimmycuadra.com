require "spec_helper"

describe PagesController do
  render_views

  describe "#about" do
    it "renders the about template" do
      get :about
      response.should render_template(:about)
    end
  end

  describe "#projects" do
    it "renders the projects template" do
      get :projects
      response.should render_template(:projects)
    end
  end
end
