RSpec.shared_examples "an element" do
  let(:resolver) { HungryForm::Resolver.new() }
  
  let(:group) { HungryForm::Group.new(:group, nil, resolver, {}) {} }

  let(:element) { described_class.new(:element_name, group, resolver, element_options) {} }

  describe "#visible?" do
    it "should be visible" do
      expect(element.visible?).to eq true
    end

    it "should not be visible" do
      element_options[:visible] = false
      expect(element.visible?).to eq false
    end

    context "when dependency is present" do
      it "should not be visible" do
        element_options[:dependency] = '{"EQ": ["0", "1"]}'
        expect(element.visible?).to eq false
      end

      it "should be visible" do
        element_options[:dependency] = '{"EQ": ["1", "1"]}'
        expect(element.visible?).to eq true
      end
    end
  end

  describe "#label" do
    it "should have a humanized label based on element's name" do
      expect(element.label).to eq "Element name"
    end

    it "should have a label defined in options" do
      element_options[:label] = "Special Label"
      expect(element.label).to eq "Special Label"
    end
  end

  describe "#method_missing" do
    it "should return existing param" do
      element_options[:html_param] = "param"
      expect(element.html_param).to eq "param"
    end

    it "should check whether param exists" do
      element_options[:html_param] = "param"
      expect(element.html_param?).to eq true
      expect(element.other_html_param?).to eq false
    end
  end
end