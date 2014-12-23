RSpec.shared_examples "a group" do
  describe "#group" do
    it "creates a nested group" do
      subject.group(:nested, {}) {}
      expect(subject.elements.first.class).to eq HungryForm::Elements::Group
    end

    it "concatenates nested element's name with the parent's one" do
      subject.group(:nested, {}) {}
      expect(subject.elements.first.name).to end_with "element_name_nested"
    end
  end

  describe "#to_hash" do
    it "should include group elements" do
      expect(subject.to_hash).to include(:elements)
    end
  end

  describe ".method_missing" do
    it "creates a nested element" do
      subject.html(:name)
      expect(subject.elements.first.class).to eq HungryForm::Elements::Html
    end

    it "concatenates nested element's name with the parent's one" do
      subject.html(:html)
      expect(subject.elements.first.name).to end_with "element_name_html"
    end
  end
end