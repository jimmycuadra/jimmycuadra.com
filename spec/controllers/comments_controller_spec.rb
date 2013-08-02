require 'spec_helper'

describe CommentsController do
  render_views

  let(:blog_post) { FactoryGirl.create(:post) }
  let(:comment_attributes) { FactoryGirl.attributes_for(:comment) }
  let(:comment) { blog_post.comments.create(comment_attributes) }

  it "requires an admin for #destroy" do
    delete :destroy, post_id: blog_post.to_param, id: comment.to_param
    expect(response).to redirect_to(root_path)
    expect(flash[:notice]).to include("not authorized")
  end

  describe "#create" do
    context "with valid attributes" do
      it "increase's the post's comment count" do
        expect {
          post :create, post_id: blog_post.to_param, comment: comment_attributes
        }.to change {
          blog_post.comments.count
        }.from(0).to(1)
      end

      it "redirects to the post" do
        post :create, post_id: blog_post.to_param, comment: comment_attributes
        expect(response).to redirect_to(blog_post)
        expect(flash[:notice]).to include("Thanks")
      end
    end

    context "with invalid attributes" do
      it "renders the post's show" do
        post :create, post_id: blog_post.to_param
        expect(response).to render_template('posts/show')
      end
    end

    it "marks comments as admin comments if the admin is logged in" do
      allow(controller).to receive(:admin?).and_return(true)
      expect {
        post :create, post_id: blog_post.to_param, comment: { comment: "I'm an admin!" }
      }.to change {
        blog_post.comments.count
      }.from(0).to(1)
    end
  end

  describe "#destroy" do
    before do
      allow(controller).to receive(:admin?).and_return(true)
    end

    it "destroys the comment" do
      delete :destroy, post_id: blog_post.to_param, id: comment.to_param
      expect { Comment.find(comment.to_param) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to the post with flash" do
      delete :destroy, post_id: blog_post.to_param, id: comment.to_param
      expect(response).to redirect_to(blog_post)
      expect(flash[:notice]).to include("destroyed")
    end
  end

  describe "#preview" do
    it "generates an HTML preview of the comment" do
      get :preview, post_id: blog_post.to_param, comment: %{Foo `bar` *baz*!}
      expect(response.body).to match(%r{<code>bar</code>})
    end

    it "uses safe Markdown options to prevent injection" do
      get :preview, post_id: blog_post.to_param, comment: %{<script>alert("lol");</script>}
      expect(response.body).not_to match(%r{<script>})
    end
  end
end
