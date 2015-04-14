require "spec_helper"

describe HungryForm::Elements::CheckboxField do
  let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  let(:group_options) { {} }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, group_options) {} }
  let(:options) { {} }

  subject { HungryForm::Elements::CheckboxField.new(:element_name, group, resolver, options) {} }

  it_behaves_like 'an element'
  it_behaves_like 'an active element'

  describe "#set_value" do
    context "when resolver contains the element name" do
      before { resolver_options[:params] = {"group_element_name" => "on"} }

      it "should be checked" do
        expect(subject.attributes[:checked]).to eq 'checked'
      end
    end

    context "when resolver doesn't contain the element name" do
      it "should not be cheched" do
        expect(subject.attributes[:checked]).to eq ''
      end
    end
  end
end
