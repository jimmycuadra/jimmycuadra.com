class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.order("name asc")
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name)
  end
end
