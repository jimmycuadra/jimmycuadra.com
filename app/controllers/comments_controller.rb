class CommentsController < ApplicationController
  before_filter :require_admin, :only => :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.admin! if admin?
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
    redirect_to @post, :notice => "The comment was destroyed."
  end
end
