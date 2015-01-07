RSpec.shared_examples "an element with options" do
  describe ".new" do
    it "should raise an exception if there is no options provided" do
      options.delete(:options)
      expect { described_class.new(:element_name, group, resolver, options) }.to raise_error(HungryForm::HungryFormException)
    end

    it "should have options" do
      options[:options] = {"1" => "First", "2" => "Last"}
      expect(subject.options).to eq({"1" => "First", "2" => "Last"})
    end

    it "should convert options to hash" do
      options[:options] = ->(el) {{"1" => "First", "2" => "Last"}}
      expect(subject.options).to eq({"1" => "First", "2" => "Last"})
    end
  end

  describe "#to_hash" do
    it "should include options" do
      expect(subject.to_hash).to include(:options)
    end
  end
end