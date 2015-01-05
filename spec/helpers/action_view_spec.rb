require 'spec_helper'

describe 'HungryForm::ActionView', :if => defined?(Rails), :type => :helper do
  let(:form_params) { {} }
  let(:form) do 
    HungryForm::Form.new params: form_params do
      page :first do
        text_field :first_name
        text_field :last_name
      end

      page :second do
        text_field :email
      end
    end
  end

  before { helper.params.merge!(controller: 'hungry_form', action: 'show') }

  describe '#hungry_link_to_next_page' do
    let(:params) { {} }
    subject { helper.hungry_link_to_next_page(form, "Next", params) }

    it { is_expected.to include("data-rel=\"hungry-form-#{form.__id__}\"") }
    it { is_expected.to include('data-form-action="next"') }

    context 'when method is GET' do
      it { is_expected.to include('/hungryform/second') }
      it { is_expected.to include('data-form-method="get"') }
    end

    context 'when method is POST' do
      before { params[:method] = :post }

      it { is_expected.to include('/hungryform/first') }
      it { is_expected.to include('data-form-method="post"') }
    end

    context 'when it is the last page' do
      before { form_params[:page] = 'second' }

      it { is_expected.to be_nil }
    end
  end

  describe '#hungry_link_to_prev_page' do
    let(:form_params) { { page: 'second' } }
    let(:params) { {} }
    subject { helper.hungry_link_to_prev_page(form, "Prev", params) }

    it { is_expected.to include("data-rel=\"hungry-form-#{form.__id__}\"") }
    it { is_expected.to include('data-form-action="prev"') }

    context 'when method is GET' do
      it { is_expected.to include('/hungryform/first') }
      it { is_expected.to include('data-form-method="get"') }
    end

    context 'when method is POST' do
      before { params[:method] = :post }
      
      it { is_expected.to include('/hungryform/second') }
      it { is_expected.to include('data-form-method="post"') }
    end

    context 'when it is the first page' do
      before { form_params[:page] = 'first' }

      it { is_expected.to be_nil }
    end
  end

  describe '#hungry_link_to_page' do
    let(:params) { {} }
    subject { helper.hungry_link_to_page(form, form.pages.last, params) }

    it { is_expected.to include("data-rel=\"hungry-form-#{form.__id__}\"") }
    it { is_expected.to include('data-form-action="page"') }

    context 'when method is GET' do
      it { is_expected.to include('/hungryform/second') }
      it { is_expected.to include('data-form-method="get"') }
    end

    context 'when method is POST' do
      before { params[:method] = :post }
      
      it { is_expected.to include('/hungryform/first') }
      it { is_expected.to include('data-form-method="post"') }
    end
  end

  describe '#hungry_form_for' do
    subject { helper.hungry_form_for(form) }

    it 'renders a form' do
      expect(subject).to include('<form')
      expect(subject).to include("data-rel=\"hungry-form-#{form.__id__}\"")
      expect(subject).to match /<input(?=.*name="form_action")(?=.*id="form_action")/ #Mandatory hidden action field
      expect(subject).to include('First name')
      expect(subject).to include('Last name')
      expect(subject).to include('Next')
    end

    it 'renders only a current page' do
      expect(subject).to include('<h1>First</h1>')
      expect(subject).not_to include('<h1>Second</h1>')
    end
  end

  describe '#hungry_form_submit' do
    pending
  end
end
