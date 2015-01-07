require "spec_helper"

describe HungryForm::Elements::Page do
  let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }

  let(:options) { {} }
  subject { HungryForm::Elements::Page.new(:element_name, nil, resolver, options) {} }

  it_behaves_like 'an element'
  it_behaves_like 'a group'

  describe ".new" do
    it "should have one element" do
      subject = HungryForm::Elements::Page.new(:element_name, nil, resolver, options) do
        html :html_name, value: "<p>Test html block</p>"
      end
      expect(subject.elements.size).to eq 1
    end
  end

  describe "#group" do 
    it "should contain a group" do
      subject.group(:group_name, {}) {}
      expect(subject.elements.first.class).to eq HungryForm::Elements::Group
    end
  end
end