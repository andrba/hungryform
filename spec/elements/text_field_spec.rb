require "spec_helper"

describe HungryForm::TextField do
	let(:resolver) { HungryForm::Resolver.new() }
	let(:options) { {:required => true} }
	subject(:element) { HungryForm::TextField.new(:text_field, "", options, resolver) }

	it_behaves_like "an active element"

	describe "#valid?" do
		context "when required" do
			it "is valid" do
				subject.value = "Text field value"
				expect(subject.valid?).to eq true
			end

			it "is invalid" do
				subject.value = ""
				expect(subject.valid?).to eq false
			end
		end
	end

end