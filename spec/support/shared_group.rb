RSpec.shared_examples "a group" do
  let(:resolver) { HungryForm::Resolver.new() }
  
  let(:page) { described_class.new(:parent_name, nil, resolver, {}) {} }

  let(:group_options) { {} }
  let(:group) { described_class.new(:name, page, resolver, group_options) {} }

  it_behaves_like "an element" do
    let(:element_options) { group_options }
  end

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

  describe "#to_hash" do
    it "should include group elements" do
      expect(group.to_hash).to include(:elements)
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