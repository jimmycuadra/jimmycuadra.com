require 'spec_helper'

describe TagsController do
  render_views

  describe "#index" do
    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end

    it "gets all the tags in alphabetical order" do
      Factory.create(:post, :tag_list => "banana, apple, carrot")
      get :index
      assigns(:tags).map(&:name).should == ["apple", "banana", "carrot"]
    end
  end

  describe "#show" do
    before(:each) do
      @post = Factory.create(:post, :tag_list => "ruby")
      @tag = ActsAsTaggableOn::Tag.first
    end

    it "renders the show template" do
      get :show, :id => @tag.to_param
      response.should render_template(:show)
    end

    it "finds the tag" do
      get :show, :id => @tag.to_param
      assigns(:tag).should == @tag
    end

    it "finds the tagged posts" do
      get :show, :id => @tag.to_param
      assigns(:posts).should == [@post]
    end

    it "enforces friendly URLs" do
      get :show, :id => @tag.id
      response.status.should == 301
    end
  end
end
