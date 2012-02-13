# coding: utf-8
require 'spec_helper'

describe ActsAsTaggableOn::Tag do
  it "generates a slug when saved" do
    subject.name = 'tag'
    subject.save
    subject.slug.should_not be_nil
  end

  it "approximates ASCII in generated slugs" do
    subject.name = "My résumé"
    subject.save
    subject.slug.should == "my-resume"
  end

  it "converts underscores to dashes in generated slugs" do
    subject.name = "this_has_underscores"
    subject.save
    subject.slug.should == "this-has-underscores"
  end
end
