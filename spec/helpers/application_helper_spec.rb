require 'spec_helper'

describe ApplicationHelper do
  describe "#markdown" do
    it "uses hard wraps" do
      markdown("foo\nbar").should =~ %r{<br>}
    end

    it "autolinks URLs" do
      markdown("http://foo.com/").should =~ %r{href}
    end

    it "should not add emphasis in Ruby method names" do
      markdown("foo_bar_baz").should_not =~ %r{em}
    end

    it "highlights fenced code blocks with CodeRay" do
      markdown("``` ruby\nclass Foo; end\n```").should =~ /CodeRay/
    end

    context "with the :safe option" do
      it "removes HTML" do
        markdown("<b>lololol</b>", safe: true).should_not =~ /<b>/
      end
    end
  end
end
