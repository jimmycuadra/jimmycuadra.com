class CommentsController < ApplicationController
  before_filter :require_admin, only: :destroy

  def create
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.admin! if admin?
    if @comment.save
      redirect_to @post, notice: "Thanks for your comment!"
    else
      render 'posts/show', layout: 'application'
    end
  end

  def destroy
    @post = Post.friendly.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @post, notice: "The comment was destroyed."
  end

  def preview
    render inline: JimmyCuadra::Markdown.render(params[:comment], safe: true)
  end

  private

  def comment_params
    params[:comment] && params[:comment].permit(%i{name email url comment})
  end
end
