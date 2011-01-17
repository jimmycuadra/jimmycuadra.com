require 'spec_helper'

describe CommentsController do
  render_views

  describe "#create" do
    before(:each) do
      @post = Factory(:post)
    end

    it "requires a user" do
      post :create, :post_id => @post.to_param
      response.should redirect_to(root_url)
      flash[:notice].should include("must be logged in")
    end

    context "when a user is logged in" do
      before(:each) do
        log_in_as_user
        @comment_attributes = Factory.attributes_for(:comment)
      end

      context "with valid attributes" do
        it "increase's the post's comment count" do
          expect {
            post :create, :post_id => @post.to_param, :comment => @comment_attributes
          }.to change {
            @post.comments.count
          }.from(0).to(1)
        end

        it "redirects to the post" do
          post :create, :post_id => @post.to_param, :comment => @comment_attributes
          response.should redirect_to(@post)
        end

        it "sets the flash" do
          post :create, :post_id => @post.to_param, :comment => @comment_attributes
          flash[:notice].should be
        end
      end

      context "with invalid attributes" do
        it "renders the post's show" do
          post :create, :post_id => @post.to_param
          response.should render_template('posts/show')
        end
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      @post = Factory(:post)
      @comment = @post.comments.create(Factory.attributes_for(:comment))
    end

    it "requires an admin" do
      delete :destroy, :post_id => @post.to_param, :id => @comment.to_param
      response.should redirect_to(root_url)
      flash[:notice].should include("not authorized")
    end

    context "when an admin is logged in" do
      before(:each) do
        log_in_as_admin
      end

      it "destroys the comment" do
        delete :destroy, :post_id => @post.to_param, :id => @comment.to_param
        expect { Comment.find(@comment.to_param) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "redirects to the post" do
        delete :destroy, :post_id => @post.to_param, :id => @comment.to_param
        response.should redirect_to(@post)
      end
    end
  end
end
