require "spec_helper"

describe HungryForm::Elements::TextField do
  let(:resolver_options) { {} }
  let(:resolver) { HungryForm::Resolver.new(resolver_options) }
  let(:group_options) { {} }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, group_options) {} }
  let(:options) { {} }

  subject { HungryForm::Elements::TextField.new(:element_name, group, resolver, options) {} }

  it_behaves_like 'an element'
  it_behaves_like 'an active element'
end
