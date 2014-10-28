RSpec.shared_examples "an element" do
  let(:resolver) { HungryForm::Resolver.new() }
  let(:options) { {} }
  let(:element) { described_class.new(:name, options, resolver) {} }

  describe "#visible?" do
    it "should be visible" do
      expect(element.visible?).to eq true
    end

    it "should not be visible" do
      options[:visible] = false
      expect(element.visible?).to eq false
    end
  end
end