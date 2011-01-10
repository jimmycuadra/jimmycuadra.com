class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.order("name asc")
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    redirect_to tag_path(@tag), :status => :moved_permanently unless @tag.friendly_id_status.best?
    @posts = Post.tagged_with(@tag.name)
  end
end
