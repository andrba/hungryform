require "spec_helper"

describe HungryForm::TextAreaField do
  it_behaves_like "an active element" do
    let(:active_element_options) { {} }
  end
end