require "spec_helper"

describe HungryForm::Group do
  describe ".new" do
    it_behaves_like "an element"
    it_behaves_like "a group"
  end
end