require 'spec_helper'

describe TagsController do
  render_views

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "gets all the tags in alphabetical order" do
      FactoryGirl.create(:post, tag_list: "banana, apple, carrot")
      get :index
      expect(assigns(:tags).map(&:name)).to eq(["apple", "banana", "carrot"])
    end
  end

  describe "#show" do
    before do
      @post = FactoryGirl.create(:post, tag_list: "ruby")
      @tag = ActsAsTaggableOn::Tag.first
    end

    it "renders the show template" do
      get :show, id: @tag.to_param
      expect(response).to render_template(:show)
    end

    it "finds the tag" do
      get :show, id: @tag.to_param
      expect(assigns(:tag)).to eq(@tag)
    end

    it "finds the tagged posts" do
      get :show, id: @tag.to_param
      expect(assigns(:posts)).to eq([@post])
    end

    it "enforces friendly URLs" do
      get :show, id: @tag.id
      expect(response.status).to eq(301)
    end

    it "redirects to #index with flash if the tag is not found" do
      get :show, id: 123
      expect(response).to redirect_to(tags_path)
      expect(flash[:notice]).to include("not found")
    end
  end
end
