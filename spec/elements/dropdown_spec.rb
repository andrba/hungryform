require "spec_helper"

describe HungryForm::Dropdown do
	it_behaves_like "an element with options" do
		let(:options_element_options) do 
			{
				:options => {"1" => "First"}
			} 
		end
	end
end