require 'spec_helper'

describe PostsController do
  render_views

  [:new, :create, :edit, :update, :destroy].each do |action|
    it "requires an admin for ##{action}" do
      get action, id: 1
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to include("not authorized")
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "displays the 3 most recent posts in descending order" do
      recent_posts = 4.times.map { FactoryGirl.create(:post) }
      get :index
      expect(assigns(:posts)).to eq(recent_posts.tap { |o| o.shift }.reverse)
    end

    context "when the atom format is requested" do
      it "displays the 10 most recent posts in descending order" do
        recent_posts = 11.times.map { FactoryGirl.create(:post) }
        get :index, format: :atom
        expect(assigns(:posts)).to eq(recent_posts.tap { |o| o.shift }.reverse)
      end
    end
  end

  describe "#show" do
    before do
      FactoryGirl.create(:post)
    end

    it "renders the show template" do
      get :show, id: Post.first.to_param
      expect(response).to render_template(:show)
    end

    it "displays the post" do
      get :show, id: Post.first.to_param
      expect(assigns(:post)).to eq(Post.first)
    end

    it "enforces friendly URLs" do
      get :show, id: Post.first.id
      expect(response.status).to eq(301)
    end
  end

  context "as an admin" do
    before do
      allow(controller).to receive(:admin?).and_return(true)
    end

    describe "#new" do
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "#create" do
      context "with valid parameters" do
        it "increases the post count by 1" do
          expect {
            post :create, { post: FactoryGirl.attributes_for(:post) }
          }.to change {
            Post.count
          }.from(0).to(1)
        end

        it "redirects to the new post with flash" do
          post :create, { post: FactoryGirl.attributes_for(:post) }
          expect(response).to redirect_to assigns(:post)
          expect(flash[:notice]).to include("created")
        end
      end

      context "with invalid parameters" do
        it "renders :new" do
          post :create
          expect(response).to render_template(:new)
        end
      end
    end

    describe "#edit" do
      before do
        FactoryGirl.create(:post)
        get :edit, id: Post.first.slug
      end

      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "finds the post" do
        expect(assigns(:post)).not_to be_nil
      end
    end

    describe "#update" do
      before do
        @post = FactoryGirl.create(:post)
      end

      context "with valid parameters" do
        before do
          put :update, id: @post.id, post: { body: "Updated body" }
        end

        it "redirects to the updated post with flash" do
          expect(response).to redirect_to assigns(:post)
          expect(flash[:notice]).to include("updated")
        end
      end

      context "with invalid parameters" do
        it "renders :edit" do
          put :update, id: @post.id, post: { body: nil }
          expect(response).to render_template(:edit)
        end
      end
    end

    describe "#destroy" do
      before do
        FactoryGirl.create(:post)
      end

      it "destroys the post" do
        post_id = Post.first.id
        delete :destroy, id: post_id
        expect { Post.find(post_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "redirects to :index with flash" do
        delete :destroy, id: Post.first.id
        expect(response).to redirect_to posts_path
        expect(flash[:notice]).to include("destroyed")
      end
    end
  end
end
