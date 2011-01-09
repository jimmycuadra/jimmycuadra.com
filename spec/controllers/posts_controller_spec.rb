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

  describe "#create" do
    context "with valid parameters" do
      it "increases the post count by 1" do
        expect {
          post :create, { :post => Factory.attributes_for(:post) }
        }.to change {
          Post.count
        }.from(0).to(1)
      end

      it "redirects to the new post" do
        post :create, { :post => Factory.attributes_for(:post) }
        response.should redirect_to assigns(:post)
      end

      it "sets the flash" do
        post :create, { :post => Factory.attributes_for(:post) }
        flash[:notice].should_not be_nil
      end
    end

    context "with invalid parameters" do
      it "renders :new" do
        post :create
        response.should render_template(:new)
      end
    end
  end
end
