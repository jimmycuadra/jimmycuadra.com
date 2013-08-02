class PostsController < ApplicationController
  before_filter :require_admin, except: [:index, :show]
  before_filter :retrieve_record, only: [:show, :update, :destroy]
  before_filter :enforce_friendly_url, only: :show

  def index
    @posts = Post.all
    @posts = @posts.where(published: true) unless admin?
    @posts = @posts.order('created_at desc')

    respond_to do |format|
      format.html { @posts = @posts.paginate(page: params[:page], per_page: 3) }
      format.atom { @posts = @posts.limit(10) }
    end
  end

  def show
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: "The post was created."
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post, notice: "The post was updated."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "The post was destroyed."
  end

  private

  def post_params
    params[:post] && params[:post].permit(
      %i{title body youtube_id tag_list published}
    )
  end

  def retrieve_record
    posts = if admin?
      Post.all
    else
      Post.where(published: true)
    end
    @post = posts.friendly.find(params[:id])
  end

  def enforce_friendly_url
    redirect_to @post, status: :moved_permanently unless params[:id] == @post.friendly_id
  end
end
