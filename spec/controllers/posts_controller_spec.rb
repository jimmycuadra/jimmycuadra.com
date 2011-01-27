require 'spec_helper'

describe PostsController do
  render_views

  [:new, :create, :edit, :update, :destroy].each do |action|
    it "requires an admin for ##{action}" do
      get action, :id => 1
      response.should redirect_to(root_path)
      flash[:notice].should include("not authorized")
    end
  end

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

    context "when the atom format is requested" do
      it "displays the 10 most recent posts in descending order" do
        recent_posts = []
        11.times { |n| recent_posts.push Factory(:post) }
        get :index, :format => :atom
        assigns(:posts).should == recent_posts.tap { |o| o.shift }.reverse
      end
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
      get :show, :id => Post.first.to_param
      assigns(:post).should == Post.first
    end

    it "enforces friendly URLs" do
      get :show, :id => Post.first.id
      response.status.should == 301
    end
  end

  context "as an admin" do
    before(:each) do
      controller.stub(:admin?).and_return(true)
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

        it "redirects to the new post with flash" do
          post :create, { :post => Factory.attributes_for(:post) }
          response.should redirect_to assigns(:post)
          flash[:notice].should include("created")
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

        it "redirects to the updated post with flash" do
          response.should redirect_to assigns(:post)
          flash[:notice].should include("updated")
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

      it "redirects to :index with flash" do
        delete :destroy, :id => Post.first.id
        response.should redirect_to posts_path
        flash[:notice].should include("destroyed")
      end
    end
  end
end
