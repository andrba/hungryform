RSpec.shared_examples "an element with options" do
  let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  
  let(:group_options) { {} }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, group_options) {} }

  let(:element) { described_class.new(:element_name, group, resolver, options_element_options) {} }

  it_behaves_like "an active element" do
    let(:active_element_options) { options_element_options }
  end

  describe ".new" do
    it "should raise an exception if there is no options provided" do
      options_element_options.delete(:options) if options_element_options[:options]
      expect { described_class.new(:element_name, group, resolver, options_element_options) }.to raise_error(HungryForm::HungryFormException)
    end

    it "should have options" do
      options_element_options[:options] = {"1" => "First", "2" => "Last"}
      expect(element.options).to eq({"1" => "First", "2" => "Last"})
    end

    it "should convert options to hash" do
      options_element_options[:options] = ->(el) {{"1" => "First", "2" => "Last"}}
      expect(element.options).to eq({"1" => "First", "2" => "Last"})
    end
  end

  describe "#to_hash" do
    it "should include options" do
      expect(element.to_hash).to include(:options)
    end
  end
end