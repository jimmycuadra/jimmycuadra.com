class PostsController < ApplicationController
  def index
    @posts = Post.order('created_at desc').limit(3)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post, :notice => "The post was created."
    else
      render :new
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end
end
