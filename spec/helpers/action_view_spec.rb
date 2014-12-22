require 'spec_helper'

describe 'HungryForm::ActionView', :if => defined?(Rails), :type => :helper do
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

  describe '#hungry_link_to_next_page' do
    let(:form_params) { {} }
    let(:params) { { controller: 'hungryform', action: 'show' } }
    subject { helper.hungry_link_to_next_page(form, "Next", params: params) }

    context 'when method is GET' do
      it { is_expected.to include('/hungryform/second') }
      it { is_expected.to include('data-method="get"') }
    end

    context 'when method is POST' do
      before { params[:method] = :post }

      it { is_expected.to include('/hungryform/first') }
      it { is_expected.to include('data-method="post"') }
    end

    context 'when it is the last page' do
      before { form_params[:page] = 'second' }

      it { is_expected.to be_nil }

      it 'should render a block' do
        subject = helper.hungry_link_to_next_page(form, 'Next', params: params) do
          'Nothing is there'
        end
        
        expect(subject).to eq 'Nothing is there'
      end
    end
  end

  describe '#hungry_link_to_prev_page' do
    let(:form_params) { { page: 'second' } }
    let(:params) { { controller: 'hungryform', action: 'show' } }
    subject { helper.hungry_link_to_prev_page(form, "Next", params: params) }

    context 'when method is GET' do
      it { is_expected.to include('/hungryform/first') }
      it { is_expected.to include('data-method="get"') }
    end

    context 'when method is POST' do
      before { params[:method] = :post }
      
      it { is_expected.to include('/hungryform/second') }
      it { is_expected.to include('data-method="post"') }
    end

    context 'when it is the first page' do
      before { form_params[:page] = 'first' }

      it { is_expected.to be_nil }

      it 'should render a block' do
        subject = helper.hungry_link_to_prev_page(form, 'Prev', params: params) do
          'Nothing is there'
        end
        
        expect(subject).to eq 'Nothing is there'
      end
    end
  end

  describe '#hungry_link_to_page' do
    let(:form_params) { {} }
    let(:params) { { controller: 'hungryform', action: 'show' } }
    subject { helper.hungry_link_to_page(form, form.pages.last, form.pages.last.label, params: params) }

    context 'when method is GET' do
      it { is_expected.to include('/hungryform/second') }
      it { is_expected.to include('data-method="get"') }
    end

    context 'when method is POST' do
      before { params[:method] = :patch }
      
      it { is_expected.to include('/hungryform/first') }
      it { is_expected.to include('data-method="patch"') }
    end
  end

  describe '#hungry_form_for' do
    let(:form_params) { {} }
    let(:params) { { controller: 'hungryform', action: 'show' } }
    subject { helper.hungry_form_for(form, params: params) }

    it 'renders a form' do
      expect(subject).to include('<form')
      expect(subject).to include('name="action"') #Mandatory hidden action field
      expect(subject).to include('First name')
      expect(subject).to include('Last name')
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
