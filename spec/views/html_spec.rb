require 'spec_helper'

describe 'rendering html', :if => defined?(Rails) do
  let(:attributes) { {} }
  let(:resolver) { HungryForm::Resolver.new }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, visible: true) {} }
  let(:field) { HungryForm::Elements::Html.new(:field_name, group, resolver, attributes) }
  let(:render_params) {
    {
      partial: 'hungryform/html',
      locals: { field: field }
    }
  }

  it_behaves_like 'it is wrapped in a div'

  it 'has a body' do
    attributes[:value] = '<a href="">link</a>'
    render render_params
    expect(rendered).to include '<a href="">link</a>'
  end
end