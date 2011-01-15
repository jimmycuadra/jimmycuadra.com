require 'spec_helper'

describe ProjectsController do
  render_views

  describe "#index" do
    it "should be successful" do
      get :index
      response.should render_template(:index)
    end
  end
end
