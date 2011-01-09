require 'spec_helper'

describe PostsController do
  render_views

  describe "#index" do
    it "renders index template" do
      get :index
      response.should render_template(:index)
    end
  end
end
