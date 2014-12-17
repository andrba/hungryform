require "spec_helper"

describe HungryForm::Elements::RadioGroup do
  let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, {}) {} }

  let(:element_options) do 
    {
      :options => {
        "1" => "First", 
        "2" => "Second",
        "3" => "Third"
      }
    } 
  end
  subject { HungryForm::Elements::RadioGroup.new(:element_name, group, resolver, element_options) {} }

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