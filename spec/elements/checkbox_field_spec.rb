require "spec_helper"

describe HungryForm::Elements::CheckboxField do
  let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  let(:group_options) { {} }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, group_options) {} }
  let(:options) { {} }

  subject { HungryForm::Elements::CheckboxField.new(:element_name, group, resolver, options) {} }

  it_behaves_like 'an element'
  it_behaves_like 'a hashable element'

  describe ".new" do
    it "should have empty error" do
      expect(subject.error).to eq ""
    end

    it "should not be required if its parent is not visible" do
      group_options[:visible] = false
      options[:required] = true
      expect(subject.required?).to eq false
    end
  end

  describe "#valid?" do
    context "when required" do
      before(:each) { options[:required] = true }

      it "is valid" do
        subject.value = 1
        expect(subject.valid?).to eq true
        expect(subject.error).to eq ''
      end

      it "is invalid" do
        subject.value = 0
        expect(subject.valid?).to eq false
        expect(subject.error).to eq 'This field is required'
      end
    end
  end

  describe "#set_value" do
    it "should be checked" do
      resolver_options[:params] = { "group_element_name" => 1 }
      expect(subject.checked?).to eq true
    end

    it "should not be checked" do
      resolver_options[:params] = { "group_element_name" => 0 }
      expect(subject.checked?).to eq false
    end
  end
end
