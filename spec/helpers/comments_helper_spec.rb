require 'spec_helper'

describe CommentsHelper do
  describe "#format_comment" do
    it "escapes HTML" do
      format_comment("This is a malicious <script>alert('haha');</script>!").should_not include("<script>")
    end

    it "converts double newlines to paragraphs" do
      format_comment("First line.\n\nSecond line.").should == "<p>First line.</p><p>Second line.</p>"
    end

    it "converts single newlines not at the end of the comment to breaks" do
      format_comment("First line.\nSecond line.\n").should == "<p>First line.<br />Second line.</p>"
    end

    it "strips blackslash-r" do
      format_comment("One.\r\nTwo.").should == "<p>One.<br />Two.</p>"
    end

    it "strips empty paragraphs" do
      format_comment("First line.\n\n\n\nSecond line.").should_not include("<p></p>")
    end

    it "auto-links URLS" do
      format_comment("Check out GitHub here: https://github.com/ and tell me what you think").should include("<a href=\"https://github.com/\">https://github.com/</a>")
    end

    it "wraps comments with no newlines in a paragraph" do
      format_comment("This is a comment.").should == "<p>This is a comment.</p>"
    end
  end
end
