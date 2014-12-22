require 'spec_helper'

describe 'HungryForm::ActionView', :if => defined?(Rails), :type => :helper do
  let(:form) do 
    HungryForm::Form.new params: form_params do
      page :first do
      end

      page :second do
      end
    end
  end

  describe '#hungry_link_to_next_page' do
    let(:form_params) { {} }
    let(:params) { { controller: 'hungryform', action: 'show' } }
    subject { helper.hungry_link_to_next_page(form, "Next", params: params) }

    context "when method is GET" do
      it { is_expected.to match(/\/hungryform\/second/) }
      it { is_expected.to match(/data-method="get"/) }
    end

    context "when method is POST" do
      before { params[:method] = :post }

      it { is_expected.to match(/\/hungryform\/first/) }
      it { is_expected.to match(/data-method="post"/) }
    end

    context "when it is the last page" do
      before { form_params[:page] = 'second' }

      it { is_expected.to be_nil }

      it "should render a block" do
        subject = helper.hungry_link_to_next_page(form, "Next", params: params) do
          "Nothing is there"
        end
        
        expect(subject).to eq "Nothing is there"
      end
    end
  end

  describe '#hungry_link_to_prev_page' do
    let(:form_params) { { page: 'second' } }
    let(:params) { { controller: 'hungryform', action: 'show' } }
    subject { helper.hungry_link_to_prev_page(form, "Next", params: params) }

    context "when method is GET" do
      it { is_expected.to match(/\/hungryform\/first/) }
      it { is_expected.to match(/data-method="get"/) }
    end

    context "when method is POST" do
      before { params[:method] = :post }
      
      it { is_expected.to match(/\/hungryform\/second/) }
      it { is_expected.to match(/data-method="post"/) }
    end

    context "when it is the first page" do
      before { form_params[:page] = 'first' }

      it { is_expected.to be_nil }

      it "should render a block" do
        subject = helper.hungry_link_to_prev_page(form, "Prev", params: params) do
          "Nothing is there"
        end
        
        expect(subject).to eq "Nothing is there"
      end
    end
  end

  describe '#hungry_link_to_page' do
    let(:form_params) { {} }
    let(:params) { { controller: 'hungryform', action: 'show' } }
    subject { helper.hungry_link_to_page(form, form.pages.last, form.pages.last.label, params: params) }

    context "when method is GET" do
      it { is_expected.to match(/\/hungryform\/second/) }
      it { is_expected.to match(/data-method="get"/) }
    end

    context "when method is PATCH" do
      before { params[:method] = :patch }
      
      it { is_expected.to match(/\/hungryform\/first/) }
      it { is_expected.to match(/data-method="patch"/) }
    end
  end

  describe '#hungry_form_for' do
    pending
  end

  describe '#hungry_form_submit' do
    pending
  end
end
