RSpec.shared_examples "an active element" do
  let(:resolver) { HungryForm::Resolver.new() }
  let(:options) { {} }
  let(:element) { described_class.new(:element_name, "parent_name", options, resolver) {} }

  it_behaves_like "an element"

  describe ".new" do
    it "should have empty error" do
    	expect(element.error).to eq ""
    end
  end
end