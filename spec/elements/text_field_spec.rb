require "spec_helper"

describe HungryForm::TextField do
  it_behaves_like "an active element" do
    let(:active_element_options) { {} }
  end

  let(:resolver) { HungryForm::Resolver.new({}) }
  let(:group) { HungryForm::Group.new(:group, nil, resolver, {}) {} }
  let(:element_options) { {} }
  subject { described_class.new(:element_name, group, resolver, element_options) {} }

  describe "#to_json" do
  	it "should return a json string" do
  		expect(subject.to_json).to eq '{"group_element_name":{"visible":true,"dependency":"","name":"group_element_name","label":"Element name","required":false,"error":"","_type":"TextField"}}'
		end
	end
end