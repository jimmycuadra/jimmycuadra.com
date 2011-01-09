require 'spec_helper'

describe PostsController do
  render_views

  describe "#index" do
    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end

    it "displays the 3 most recent posts in descending order" do
      recent_posts = [Factory(:post), Factory(:post), Factory(:post)]
      get :index
      assigns(:posts).should == recent_posts.reverse
    end
  end

  describe "#show" do
    before(:each) do
      Factory(:post)
    end

    it "renders the show template" do
      get :show, :id => Post.first.to_param
      response.should render_template(:show)
    end

    it "displays the post" do
      get :show, :id => Post.first.id
      assigns(:post).should == Post.first
    end
  end
end
