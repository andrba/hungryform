require "spec_helper"

describe HungryForm do
  describe ".new" do
    subject(:form) { HungryForm.new {
      page :first do 
      end
      page :second, visible: false do 
      end
      page :third do 
      end
    } }

    it "should contain 2 pages" do
      expect(subject.pages.size).to eq 2
    end
  end

  describe "#page" do 
    subject(:form) { HungryForm.new() {} }

    it "should contain a page" do
      page_block = proc{}
      form.page(:page_name, {}, &page_block)
      expect(form.pages.first.class).to eq HungryForm::Page
    end
  end
end