require "spec_helper"

describe HungryForm::Page do
  let(:resolver) { HungryForm::Resolver.new() }
  let(:options) { {} }
  let(:page) { HungryForm::Page.new(:pagename, "", options, resolver) {} }

  describe ".new" do
    it_behaves_like "an element"
    it_behaves_like "a group"

    it "should have one element" do
      page = HungryForm::Page.new(:pagename, "", options, resolver) do
        html :html_name, value: "<p>Test html block</p>"
      end
      expect(page.elements.size).to eq 1
    end
  end

  describe "#group" do 
    it "should contain a group" do
      group_block = proc{}

      page.group(:group_name, {}, &group_block)
      expect(page.elements.first.class).to eq HungryForm::Group
    end
  end
end