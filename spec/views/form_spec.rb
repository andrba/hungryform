require 'spec_helper'

describe 'rendering a form', :if => defined?(Rails) do
  let(:form_params) { {} }
  let(:form) { 
    HungryForm::Form.new form_params do
      page :first do
        text_field :first_name
      end
      page :second do
        text_field :last_name
      end
    end
  }
  let(:render_params) {
    {
      partial: 'hungryform/form',
      locals: { form: form, views_prefix: 'hungryform' }
    }
  }

  before { 
    allow(view).to receive(:url_for).and_return('#')  
  }

  it 'renders the first page' do
    render render_params
    expect(rendered).to match /<h1>First<\/h1>/
    expect(rendered).to match /<input.*name="first_first_name"/
    expect(rendered).to match /Next/
    expect(rendered).not_to match /Prev/
  end

  it 'renders the second page' do
    form_params[:params] = { page: 'second' }
    render render_params
    expect(rendered).to match /<h1>Second<\/h1>/
    expect(rendered).to match /<input.*name="second_last_name"/
    expect(rendered).to match /Prev/
    expect(rendered).not_to match /Next/
  end
end