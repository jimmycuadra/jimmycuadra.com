class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.order("name asc")
  end

  def show
    begin
      @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return redirect_to tags_path, :notice => "That tag was not found. The full list of tags is displayed below."
    end

    redirect_to tag_path(@tag), :status => :moved_permanently unless params[:id] == @tag.friendly_id
    @posts = Post.tagged_with(@tag.name)
  end
end
