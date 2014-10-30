RSpec.shared_examples "a group" do
  let(:resolver) { HungryForm::Resolver.new() }
  let(:options) { {} }
  let(:group) { described_class.new(:name, "parent_name", options, resolver) {} }

  it_behaves_like "an element"

  describe "#group" do
    it "creates a nested group" do
      group.group(:nested, {}) {}
      expect(group.elements.first.class).to eq HungryForm::Group
    end

    it "concatenates nested element's name with the parent's one" do
      group.group(:nested, {}) {}
      expect(group.elements.first.name).to eq "parent_name_name_nested"
    end
  end

  describe ".method_missing" do
    it "creates a nested element" do
      group.html(:name)
      expect(group.elements.first.class).to eq HungryForm::Html
    end

    it "concatenates nested element's name with the parent's one" do
      group.html(:html)
      expect(group.elements.first.name).to eq "parent_name_name_html"
    end
  end
end