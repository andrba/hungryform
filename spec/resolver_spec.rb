require "spec_helper"

describe HungryForm::Resolver do
  describe ".get_value" do
    let(:element) { HungryForm::Html.new(:html_name, "parent", { value: "value" }, resolver) {} }
    subject(:resolver) { HungryForm::Resolver.new }

    it "should get value from lambda param" do
      value = subject.get_value( ->(el){ "value" } )
      expect(value).to eq "value"
    end

    it "should get value from a form element" do
      subject.elements[element.name] = element
      expect(subject.get_value("parent_html_name")).to eq "value"
    end

    it "should get value that equals the name" do
      expect(subject.get_value("name that doesn't exist")).to eq "name that doesn't exist"
    end
  end
end