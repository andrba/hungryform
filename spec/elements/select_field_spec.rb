require "spec_helper"

describe HungryForm::Elements::SelectField do
	let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  let(:group_options) { {} }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, group_options) {} }

  let(:options) do 
    {
      :options => {
        '1' => 'First', 
        'element_value' => 'Second' # element_value is checked in shared_active_element
      }
    } 
  end

  subject { HungryForm::Elements::SelectField.new(:element_name, group, resolver, options) {} }

  it_behaves_like 'an element'
  it_behaves_like 'an active element'
	it_behaves_like 'an element with options'
		
	describe '#set_value' do
		context 'when multiple enabled' do
			it 'assigns multiple values' do
				resolver_options[:params] = {"group_element_name" => ["1", "element_value"]}
				options[:multiple] = true
				expect(subject.value).to eq(["1", "element_value"])
			end
		end
	end
end