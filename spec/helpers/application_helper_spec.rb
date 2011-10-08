require 'spec_helper'

describe ApplicationHelper do
  describe "#nav_to" do
    let(:params) { { :controller => "current-controller"} }

    it "generates a normal navigation link when it's not the current controller" do
      nav_to("Title", "/link", "other-controller").should == "<li><div><a href=\"/link\" class=\"awesome\">Title</a></div></li>"
    end

    it "generates a current navigation link when it's the current controller" do
      nav_to("Title", "/link", "current-controller").should == "<li class=\"current\"><div><a href=\"/link\" class=\"awesome\">Title</a></div></li>"
    end
  end

  describe "#markdown" do
    it "processes input with Markdown" do
      markdown("# Hello world").should =~ %r{<h1>Hello world</h1>}
    end
  end

  describe "#format_comment" do
    it "processes input with Markdown" do
      format_comment("# Hello world").should =~ %r{<h1>Hello world</h1>}
    end
  end
end
