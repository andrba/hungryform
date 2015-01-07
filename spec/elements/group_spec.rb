require "spec_helper"

describe HungryForm::Elements::Group do
  let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  let(:group_options) { {} }
  let(:group) { HungryForm::Elements::Group.new(:parent_name, nil, resolver, group_options) {} }
  let(:options) { {} }
  
  subject { HungryForm::Elements::Group.new(:element_name, group, resolver, options) {} }

  it_behaves_like 'an element'
  it_behaves_like 'a group'
end