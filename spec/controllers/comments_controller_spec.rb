require 'spec_helper'

describe CommentsController do
  render_views

  it "requires an admin for #destroy" do
    @post = Factory(:post)
    @comment = @post.comments.create(Factory.attributes_for(:comment))
    delete :destroy, :post_id => @post.to_param, :id => @comment.to_param
    response.should redirect_to(root_path)
    flash[:notice].should include("not authorized")
  end

  describe "#create" do
    before(:each) do
      @post = Factory(:post)
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
        flash[:notice].should include("Thanks")
      end
    end

    context "with invalid attributes" do
      it "renders the post's show" do
        post :create, :post_id => @post.to_param
        response.should render_template('posts/show')
      end
    end

    it "marks comments as admin comments if the admin is logged in" do
      controller.stub(:admin?).and_return(true)
      expect {
        post :create, :post_id => @post.to_param, :comment => { :comment => "I'm an admin!" }
      }.to change {
        @post.comments.count
      }.from(0).to(1)
    end
  end

  describe "#destroy" do
    before(:each) do
      controller.stub(:admin?).and_return(true)
      @post = Factory(:post)
      @comment = @post.comments.create(Factory.attributes_for(:comment))
    end

    it "destroys the comment" do
      delete :destroy, :post_id => @post.to_param, :id => @comment.to_param
      expect { Comment.find(@comment.to_param) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to the post with flash" do
      delete :destroy, :post_id => @post.to_param, :id => @comment.to_param
      response.should redirect_to(@post)
      flash[:notice].should include("destroyed")
    end
  end
end
