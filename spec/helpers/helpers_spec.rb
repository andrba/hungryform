require 'spec_helper'

describe 'HungryForm::Helpers', :if => defined?(Rails) do
  let(:form) do 
    HungryForm::Form.new do
      page :first do
      end

      page :second do
      end
    end
  end

  describe '#link_to_hf_next_page' do
    subject { helper.link_to_hf_next_page form, 'Next' }
    it { is_expected.to match(/second/) }
  end
end
