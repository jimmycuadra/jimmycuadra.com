class CommentsController < ApplicationController
  def new
  end

  def create
    @post = Post.find(params[:post_id])
    @post.comments.build(params[:comment])
    if @post.save
      redirect_to @post, :notice => "Thanks for your comment!"
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @post
  end
end
