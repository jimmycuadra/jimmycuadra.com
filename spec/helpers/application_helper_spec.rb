require 'spec_helper'

describe ApplicationHelper do
  describe "#markdown" do
    it "processes input with Markdown" do
      markdown("# Hello world").should =~ %r{<h1>Hello world</h1>}
    end

    it "highlights code blocks with CodeRay" do
      markdown("``` ruby\nclass Foo; end\n```").should =~ /CodeRay/
    end

    it "uses additional options for safety when parsing comments" do
      markdown("<script>alert('lol');</script>", :safe => true).should_not =~ /script/
    end
  end
end
