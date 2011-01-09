require 'spec_helper'

describe PostsController do
  render_views

  describe "#index" do
    it "renders index template" do
      get :index
      response.should render_template(:index)
    end

    it "displays the 3 most recent posts in descending order" do
      recent_posts = [Factory(:post), Factory(:post), Factory(:post)]
      get :index
      assigns(:posts).should == recent_posts.reverse
    end
  end
end
