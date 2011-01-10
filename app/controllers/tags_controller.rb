class TagsController < ApplicationController
  def index
    @tags = Tag.order("name asc")
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name)
  end
end
