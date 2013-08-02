# coding: utf-8
require 'spec_helper'

describe ActsAsTaggableOn::Tag do
  it "generates a slug when saved" do
    subject.name = 'tag'
    subject.valid?
    expect(subject.slug).not_to be_nil
  end

  it "approximates ASCII in generated slugs" do
    subject.name = "My résumé"
    subject.valid?
    expect(subject.slug).to eq("my-resume")
  end

  it "converts underscores to dashes in generated slugs" do
    subject.name = "this_has_underscores"
    subject.valid?
    expect(subject.slug).to eq("this-has-underscores")
  end

  it "does not alter underscores in the tag names" do
    subject.name = "this_has_underscores"
    subject.valid?
    expect(subject.name).to eq("this_has_underscores")
  end
end
