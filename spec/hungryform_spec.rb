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
    pending
  end
end