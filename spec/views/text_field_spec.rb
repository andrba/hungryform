require 'spec_helper'

describe 'rendering text field', :if => defined?(Rails) do
  let(:attributes) { {} }
  let(:resolver) { HungryForm::Resolver.new }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, visible: true) {} }
  let(:field) { HungryForm::Elements::TextField.new(:field_name, group, resolver, attributes) }
  let(:render_params) {
    {
      partial: 'hungryform/text_field',
      locals: { field: field }
    }
  }

  it_behaves_like 'it is wrapped in a div'
  it_behaves_like 'rendered active element'

  it 'has an input' do
    render render_params
    expect(rendered).to match /<input.*id="group_field_name"/
  end

  it 'has an input with value' do
    attributes[:value] = 'default value'
    render render_params
    expect(rendered).to match /<input.*value="default value"/
  end

  # As a class is gonna be in the wrapper
  it 'does not have an input with a class attribute' do
    attributes[:class] = 'my_class'
    render render_params
    expect(rendered).not_to match /<input.*class="my_class"/
  end
end