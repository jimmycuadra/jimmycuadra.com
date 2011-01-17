class CommentsController < ApplicationController
  before_filter :require_user, :only => :create
  before_filter :require_admin, :only => :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @post, :notice => "Thanks for your comment!"
    else
      render 'posts/show', :layout => 'application'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @post
  end
end
