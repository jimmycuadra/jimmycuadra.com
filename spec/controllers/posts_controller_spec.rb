require 'spec_helper'

describe PostsController do
  render_views

  describe "#index" do
    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end

    it "displays the 3 most recent posts in descending order" do
      recent_posts = [Factory(:post), Factory(:post), Factory(:post), Factory(:post)]
      get :index
      assigns(:posts).should == recent_posts.tap { |o| o.shift }.reverse
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

  describe "#new" do
    it "renders the new template" do
      get :new
      response.should render_template(:new)
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

  describe "#edit" do
    before(:each) do
      Factory(:post)
      get :edit, :id => Post.first.id
    end

    it "renders the edit template" do
      response.should render_template(:edit)
    end

    it "finds the post" do
      assigns(:post).should_not be_nil
    end
  end

  describe "#update" do
    before(:each) do
      @post = Factory(:post)
    end

    context "with valid parameters" do
      before(:each) do
        put :update, :id => @post.id, :post => { :body => "Updated body" }
      end

      it "redirects to the updated post" do
        response.should redirect_to assigns(:post)
      end

      it "sets the flash" do
        flash[:notice].should_not be_nil
      end
    end

    context "with invalid parameters" do
      it "renders :edit" do
        put :update, :id => @post.id, :post => { :body => nil }
        response.should render_template(:edit)
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      Factory(:post)
    end

    it "destroys the post" do
      post_id = Post.first.id
      delete :destroy, :id => post_id
      expect { Post.find(post_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to :index" do
      delete :destroy, :id => Post.first.id
      response.should redirect_to posts_path
    end
  end
end
