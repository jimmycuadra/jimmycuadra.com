require 'spec_helper'

describe TagsController do
  describe "#index" do
    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end

    it "gets all the tags in alphabetical order" do
      ["banana", "apple", "carrot"].each do |tag|
        Factory.create(:tag, :name => tag)
      end

      get :index
      assigns(:tags).map(&:name).should == ["apple", "banana", "carrot"]
    end
  end
end
