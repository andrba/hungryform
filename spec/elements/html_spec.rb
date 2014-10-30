require "spec_helper"

describe HungryForm::Html do
  describe ".new" do
    let(:resolver) { HungryForm::Resolver.new() }
    let(:options) { {} }
    subject { HungryForm::Html.new(:html, "body text", options, resolver) {} }

    it_behaves_like "an element"
    
    it "should have a value" do
      expect(subject.body).to eq "body text"
    end

  end
end