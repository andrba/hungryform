require "spec_helper"

describe HungryForm::Group do
  describe ".new" do
    let(:resolver) { HungryForm::Resolver.new() }
    let(:options) { }
    subject { HungryForm::Group.new(:group, options, resolver) {} }

    it_behaves_like "an element"
    it_behaves_like "a group"
  end
end