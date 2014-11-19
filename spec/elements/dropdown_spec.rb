require "spec_helper"

describe HungryForm::Dropdown do
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
end