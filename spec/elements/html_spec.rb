require "spec_helper"

describe HungryForm::Elements::Html do
  it_behaves_like "an element" do
    let(:element_options) { {} }
  end

  let(:resolver) { HungryForm::Resolver.new() }
  let(:options) { {value: "body text"} }
  subject { HungryForm::Elements::Html.new(:html, nil, resolver, options) {} }

  describe ".new" do
    it "should have a value" do
      expect(subject.value).to eq "body text"
    end
  end
end