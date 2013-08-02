require 'spec_helper'

describe SessionsController do
  render_views

  [:new, :create].each do |action|
    it "requires no admin for ##{action}" do
      allow(controller).to receive(:admin?).and_return(true)
      get action
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to include("already logged in")
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with a valid password" do
      before do
        ENV['ADMIN_PASSWORD'] = 'password'
        post :create, password: 'password'
      end

      it "logs in as an admin" do
        expect(controller.admin?).to be_true
      end

      it "redirects to the root with a flash" do
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to include("logged in")
      end
    end

    context "with an invalid password" do
      it "renders the new template with a flash" do
        ENV['ADMIN_PASSWORD'] = 'password'
        post :create, password: 'foo'
        expect(response).to render_template(:new)
        expect(flash[:notice]).to include("Invalid")
      end
    end
  end

  describe "#destroy" do
    before do
      session[:admin] == true
      delete :destroy
    end

    it "logs the user out" do
      expect(controller.admin?).to be_false
    end

    it "redirects to the root with a flash" do
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to include("logged out")
    end
  end
end
