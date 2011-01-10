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

  describe "#textile" do
    it "processes input with Textile" do
      textile("hello *world*").should == "<p>hello <strong>world</strong></p>"
    end

    it "wraps @@@ in a code block" do
      textile("@@@\nfoo\n@@@").strip.should == CodeRay.scan('foo', nil).div(:css => :class).strip
    end

    it "doesn't process Textile in code blocks" do
      textile("@@@\nfoo *bar*\n@@@").strip.should == CodeRay.scan('foo *bar*', nil).div(:css => :class).strip
    end

    it "accepts a language for code blocks" do
      textile("@@@ ruby\n@foo\n@@@").strip.should == CodeRay.scan('@foo', 'ruby').div(:css => :class).strip
    end

    it "processes code blocks in the middle of other Textile" do
      textile("foo\n@@@\ntest\n@@@\nbar").should include(CodeRay.scan('test', 'ruby').div(:css => :class).strip)
    end

    it "removes backslash-r in code blocks" do
      textile("\r\n@@@\r\nfoo\r\n@@@\r\n").strip.should == CodeRay.scan('foo', nil).div(:css => :class).strip
    end
  end
end
