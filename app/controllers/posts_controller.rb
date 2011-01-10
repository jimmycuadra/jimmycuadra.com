class PostsController < ApplicationController
  before_filter :retrieve_record, :only => [:show, :update, :destroy]

  def index
    @posts = Post.order('created_at desc')

    respond_to do |format|
      format.html { @posts = @posts.paginate(:page => params[:page], :per_page => 3) }
    end
  end

  def show
  end

  def new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post, :notice => "The post was created."
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice => "The post was updated."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def retrieve_record
    @post = Post.find(params[:id])
  end
end
