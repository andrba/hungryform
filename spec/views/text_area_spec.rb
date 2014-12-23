require 'spec_helper'

describe 'rendering text area', :if => defined?(Rails) do
  let(:attributes) { {} }
  let(:resolver) { HungryForm::Resolver.new }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, visible: true) {} }
  let(:field) { HungryForm::Elements::TextArea.new(:field_name, group, resolver, attributes) }
  let(:render_params) {
    {
      partial: 'hungryform/text_area',
      locals: { field: field }
    }
  }

  it_behaves_like 'it is wrapped in a div'
  it_behaves_like 'rendered active element'

  it 'has a text area' do
    render render_params
    expect(rendered).to match /<textarea.*id="group_field_name"/
  end

  it 'has a textarea with value' do
    attributes[:value] = 'default value'
    render render_params
    expect(rendered).to match /<textarea.*default value/m
  end

  # As a class is gonna be in the wrapper
  it 'does not have a textarea with a class attribute' do
    attributes[:class] = 'my_class'
    render render_params
    expect(rendered).not_to match /<textarea.*class="my_class"/
  end
end