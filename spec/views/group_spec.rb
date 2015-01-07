require 'spec_helper'

describe 'rendering a group', :if => defined?(Rails) do
  let(:attributes) { {} }
  let(:resolver) { HungryForm::Resolver.new }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, visible: true) {} }
  let(:field) { 
    HungryForm::Elements::Group.new(:field_name, group, resolver, attributes) do
      text_field :first
      text_field :second
      group :nested do
        text_field :third
        text_field :forth
      end
    end
  }
  let(:render_params) {
    {
      partial: 'hungryform/group',
      locals: { field: field, views_prefix: 'hungryform' }
    }
  }

  it_behaves_like 'it is wrapped in a div'

  it 'has a text field' do
    render render_params
    expect(rendered).to match /<input.*id="group_field_name_first"/
  end

  it 'has a nested group' do
    render render_params
    expect(rendered).to match /<div.*id="group_field_name_nested_wrapper"/
  end
end