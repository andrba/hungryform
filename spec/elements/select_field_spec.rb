require "spec_helper"

describe HungryForm::SelectField do
	let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  
  let(:group_options) { {} }
  let(:group) { HungryForm::Group.new(:group, nil, resolver, group_options) {} }

  let(:element_options) do 
		{
			:options => {
				"1" => "First", 
				"2" => "Second",
				"3" => "Third"
			}
		} 
	end
  let(:element) { HungryForm::SelectField.new(:element_name, group, resolver, element_options) {} }

	it_behaves_like "an element with options" do
		let(:options_element_options) do 
			{
				:options => {
					"1" => "First", 
					"element_value" => "Second" # element_value is checked in shared_active_element
				}
			} 
		end
	end

	context "when multiple enabled" do
		it "assigns multiple values" do
			resolver_options[:params] = {"group_element_name" => ["1", "2", "3"]}
			element_options[:multiple] = true
			expect(element.value).to eq(["1", "2", "3"])
		end
	end
end