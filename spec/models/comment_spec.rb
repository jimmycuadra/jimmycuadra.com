require 'spec_helper'

describe Comment do
  before(:each) do
    @post = Factory(:post)
    @comment = @post.comments.build(Factory.attributes_for(:comment))
  end

  it "saves valid records" do
    @comment.should be_valid
  end

  it "requires a comment" do
    @comment.comment = nil
    @comment.valid?
    @comment.should have(1).error_on(:comment)
  end
end
