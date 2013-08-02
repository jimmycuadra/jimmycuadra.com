require 'spec_helper'

describe ApplicationHelper do
  describe "#markdown" do
    it "uses hard wraps" do
      expect(markdown("foo\nbar")).to match(%r{<br>})
    end

    it "autolinks URLs" do
      expect(markdown("http://foo.com/")).to match(%r{href})
    end

    it "should not add emphasis in Ruby method names" do
      expect(markdown("foo_bar_baz")).not_to match(%r{em})
    end

    it "highlights fenced code blocks with CodeRay" do
      expect(markdown("``` ruby\nclass Foo; end\n```")).to match(/CodeRay/)
    end

    context "with the :safe option" do
      it "removes HTML" do
        expect(markdown("<b>lololol</b>", safe: true)).not_to match(/<b>/)
      end
    end
  end
end
