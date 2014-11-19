require "spec_helper"

describe HungryForm::Validator do
  let(:resolver) { HungryForm::Resolver.new() }
  let(:group) { HungryForm::Group.new(:group, nil, resolver, {}) {} }

  let(:element_options) { {} }
  let(:element) { HungryForm::TextField.new(:element_name, group, resolver, element_options) {} }

  describe "required" do
    it "should return nil when the element's value is present" do
      element_options[:value] = "value"
      expect(HungryForm::Validator.required(element, true)).to be nil
    end

    it "should return error when the element's value is not present" do
      element_options[:value] = ""
      expect(HungryForm::Validator.required(element, true)).to eq "is required"
    end

    it "should return the result of the custom required validation" do
      element_options[:value] = "value"
      expect(HungryForm::Validator.required(element, ->(el) { "not ok" if el.value != "custom" })).to eq "not ok"
    end
  end

  describe "validation" do
    it "should return the result of the custom validation" do
      element_options[:value] = "value"
      expect(HungryForm::Validator.validation(element, ->(el) { "not ok" if el.value != "custom" })).to eq "not ok"
    end
  end
end