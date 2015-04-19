RSpec.shared_examples "an active element" do
  it_behaves_like 'a hashable element'

  describe ".new" do
    it "should have empty error" do
      expect(subject.error).to eq ""
    end

    it "should not be required if its parent is not visible" do
      group_options[:visible] = false
      options[:required] = true
      expect(subject.required?).to eq false
    end

    it "should have a nil value" do
      expect(subject.value).to be nil
    end

    it "should have a value from form params" do
      resolver_options[:params]= {"group_element_name" => "element_value" }
      expect(subject.value).to eq "element_value"
    end

    it "should have a value from element structure" do
      options[:value] = "element_value"
      expect(subject.value).to eq "element_value"
    end
  end

  describe "#valid?" do
    context "when required" do
      before(:each) { options[:required] = true }

      it "is valid" do
        subject.value = "value"
        expect(subject.valid?).to eq true
        expect(subject.error).to eq ''
      end

      it "is invalid" do
        subject.value = ''
        expect(subject.valid?).to eq false
        expect(subject.error).to eq 'This field is required'
      end
    end
  end
end