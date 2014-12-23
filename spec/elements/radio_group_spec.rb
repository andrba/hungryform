require "spec_helper"

describe HungryForm::Elements::RadioGroup do
  let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  let(:group_options) { {} }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, group_options) {} }

  let(:options) do 
    {
      :options => {
        "1" => "First", 
        "element_value" => "Second" # element_value is checked in shared_active_element
      }
    } 
  end

  subject { HungryForm::Elements::RadioGroup.new(:element_name, group, resolver, options) {} }

  it_behaves_like 'an element'
  it_behaves_like 'an active element'
  it_behaves_like 'an element with options'
end