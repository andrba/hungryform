require 'spec_helper'

describe 'HungryForm::ActionView', :if => defined?(Rails), :type => :helper do
  let(:form) do 
    HungryForm::Form.new do
      page :first do
      end

      page :second do
      end
    end
  end

end
