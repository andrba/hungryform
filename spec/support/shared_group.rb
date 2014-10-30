RSpec.shared_examples "a group" do
  let(:resolver) { HungryForm::Resolver.new() }
  let(:options) { {} }
  let(:group) { described_class.new(:name, options, resolver) {} }

  describe "#group" do
    it "creates a nested group" do
      group_block = proc{}
      group.group(:nested, {}, &group_block)

      expect(group.elements.first.class).to eq HungryForm::Group
    end

    it "concatenates nested element's name with the parent's one" do
      group_block = proc{}
      group.group(:nested, {}, &group_block)

      expect(group.elements.first.name).to eq "name_nested"
    end
  end

  describe ".method_missing" do
    it "creates a nested element" do
      group.html(:name, "body")
      expect(group.elements.first.class).to eq HungryForm::Html
    end

    it "concatenates nested element's name with the parent's one" do
      group.html(:html, "body")
      expect(group.elements.first.name).to eq "name_html"
    end
  end
end