require 'spec_helper'

describe CommentsController do
  render_views

  let(:blog_post) { FactoryGirl.create(:post) }
  let(:comment_attributes) { FactoryGirl.attributes_for(:comment) }
  let(:comment) { blog_post.comments.create(comment_attributes) }

  it "requires an admin for #destroy" do
    delete :destroy, :post_id => blog_post.to_param, :id => comment.to_param
    response.should redirect_to(root_path)
    flash[:notice].should include("not authorized")
  end

  describe "#create" do
    context "with valid attributes" do
      it "increase's the post's comment count" do
        expect {
          post :create, :post_id => blog_post.to_param, :comment => comment_attributes
        }.to change {
          blog_post.comments.count
        }.from(0).to(1)
      end

      it "redirects to the post" do
        post :create, :post_id => blog_post.to_param, :comment => comment_attributes
        response.should redirect_to(blog_post)
        flash[:notice].should include("Thanks")
      end
    end

    context "with invalid attributes" do
      it "renders the post's show" do
        post :create, :post_id => blog_post.to_param
        response.should render_template('posts/show')
      end
    end

    it "marks comments as admin comments if the admin is logged in" do
      controller.stub(:admin?).and_return(true)
      expect {
        post :create, :post_id => blog_post.to_param, :comment => { :comment => "I'm an admin!" }
      }.to change {
        blog_post.comments.count
      }.from(0).to(1)
    end
  end

  describe "#destroy" do
    before do
      controller.stub(:admin?).and_return(true)
    end

    it "destroys the comment" do
      delete :destroy, :post_id => blog_post.to_param, :id => comment.to_param
      expect { Comment.find(comment.to_param) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to the post with flash" do
      delete :destroy, :post_id => blog_post.to_param, :id => comment.to_param
      response.should redirect_to(blog_post)
      flash[:notice].should include("destroyed")
    end
  end

  describe "#preview" do
    it "generates an HTML preview of the comment" do
      get :preview, post_id: blog_post.to_param, comment: %{Foo `bar` *baz*!}
      response.body.should =~ %r{<code>bar</code>}
    end

    it "uses safe Markdown options to prevent injection" do
      get :preview, post_id: blog_post.to_param, comment: %{<script>alert("lol");</script>}
      response.body.should_not =~ %r{<script>}
    end
  end
end
