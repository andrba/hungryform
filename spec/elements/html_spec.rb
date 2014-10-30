require "spec_helper"

describe HungryForm::Html do
	it_behaves_like "an element"

  describe ".new" do
    let(:resolver) { HungryForm::Resolver.new() }
    let(:options) { {value: "body text"} }
    subject { HungryForm::Html.new(:html, "parent", options, resolver) {} }

    it "should have a value" do
      expect(subject.value).to eq "body text"
    end

  end
end