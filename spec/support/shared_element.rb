RSpec.shared_examples "an element" do
  let(:resolver) { HungryForm::Resolver.new() }
  let(:options) { {} }
  let(:element) { described_class.new(:element_name, "parent", options, resolver) {} }

  describe "#visible?" do
    it "should be visible" do
      expect(element.visible?).to eq true
    end

    it "should not be visible" do
      options[:visible] = false
      expect(element.visible?).to eq false
    end
  end

  describe "#label" do
    it "should have a humanized label based on element's name" do
      expect(element.label).to eq "Element name"
    end

    it "should have a label defined in options" do
      options[:label] = "Special Label"
      expect(element.label).to eq "Special Label"
    end
  end
end