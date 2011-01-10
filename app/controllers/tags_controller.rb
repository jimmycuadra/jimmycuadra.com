class TagsController < ApplicationController
  def index
    @tags = Tag.order("name asc")
  end
end
