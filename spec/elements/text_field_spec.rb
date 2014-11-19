require "spec_helper"

describe HungryForm::TextField do
  it_behaves_like "an active element" do
    let(:active_element_options) { {} }
  end
end