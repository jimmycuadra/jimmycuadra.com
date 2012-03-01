# coding: utf-8
require 'spec_helper'

describe ActsAsTaggableOn::Tag do
  it "generates a slug when saved" do
    subject.name = 'tag'
    subject.valid?
    subject.slug.should_not be_nil
  end

  it "approximates ASCII in generated slugs" do
    subject.name = "My résumé"
    subject.valid?
    subject.slug.should == "my-resume"
  end

  it "converts underscores to dashes in generated slugs" do
    subject.name = "this_has_underscores"
    subject.valid?
    subject.slug.should == "this-has-underscores"
  end

  it "does not alter underscores in the tag names" do
    subject.name = "this_has_underscores"
    subject.valid?
    subject.name.should == "this_has_underscores"
  end
end
