require "spec_helper"

describe HungryForm::Elements::Html do
  let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  let(:group_options) { {} }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, group_options) {} }
  let(:options) { { value: 'body text' } }

  subject { HungryForm::Elements::Html.new(:element_name, nil, resolver, options) {} }

  it_behaves_like 'an element'

  describe '.new' do
    it 'should have a value' do
      expect(subject.value).to eq 'body text'
    end
  end
end