RSpec.shared_examples "an element" do
  describe "#visible?" do
    it "should be visible" do
      expect(subject.visible?).to eq true
    end

    it "should not be visible" do
      options[:visible] = false
      expect(subject.visible?).to eq false
    end

    context "when dependency is present" do
      it "should not be visible" do
        options[:dependency] = '{"EQ": ["0", "1"]}'
        expect(subject.visible?).to eq false
      end

      it "should be visible" do
        options[:dependency] = '{"EQ": ["1", "1"]}'
        expect(subject.visible?).to eq true
      end
    end
  end

  describe "#label" do
    it "should have a humanized label based on element's name" do
      expect(subject.label).to eq "Element name"
    end

    it "should have a label defined in options" do
      options[:label] = "Special Label"
      expect(subject.label).to eq "Special Label"
    end
  end

  describe "#to_hash" do
    it "should include visible, dependency, name and label" do
      options.merge!(dependency: '{"EQ": [1, 1]}', name: 'name')
      expect(subject.to_hash).to include(:visible, :dependency, :name, :label)
    end
  end
end