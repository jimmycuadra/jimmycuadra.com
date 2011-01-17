module ControllerMacros
  def log_in_as_user
    controller.stub(:current_user).and_return(mock(User, :id => 2, :username => "Bongo"))
    session[:user_id] = controller.current_user.id
  end

  def log_in_as_admin
    controller.stub(:current_user).and_return(mock(User, :id => 1, :username => "Jimmy"))
    session[:user_id] = controller.current_user.id
  end

  module ClassMethods
    def it_provides_authentication_with(provider, omniauth)
      context "authenticating with #{provider.to_s}" do
        let(:omniauth) { omniauth }

        before(:each) do
          request.env["omniauth.auth"] = omniauth
        end

        it "logs the user in" do
          post :create, :provider => provider.to_s
          session[:user_id].should == User.first.id
        end

        it "redirects the user back" do
          session[:return_to] = "http://dev.jimmycuadra.com/foobar"
          post :create, :provider => provider.to_s
          response.should redirect_to("http://dev.jimmycuadra.com/foobar")
        end

        context "when the authentication doesn't exist yet" do
          it "creates a new user" do
            expect {
              post :create, :provider => provider.to_s
            }.to change {
              User.count
            }.from(0).to(1)
          end
        end

        context "when the authentication exists" do
          it "does not create a new user" do
            User.send("build_from_#{provider.to_s}", omniauth).save!

            expect {
              post :create, :provider => provider.to_s
            }.to_not change {
              User.count
            }
          end
        end
      end
    end
  end
end
