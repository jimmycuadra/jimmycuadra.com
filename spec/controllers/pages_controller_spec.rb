require "spec_helper"

describe PagesController do
  render_views

  describe "#resume" do
    it "renders the resume template" do
      get :resume
      response.should render_template(:resume)
    end
  end

  describe "#projects" do
    it "renders the projects template" do
      get :projects
      response.should render_template(:projects)
    end
  end
end
