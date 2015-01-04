require "spec_helper"

feature 'User clicks next', :if => defined?(Rails), :js => true do
  before {
    allow_any_instance_of(HungryFormController).to receive(:form) do |params|
      HungryForm::Form.new params: params do
        page :first do
          text_field :field1
        end

        page :second do
          text_field :field2
        end

        page :third do
          text_field :field3
        end
      end
    end
  }

  scenario 'they see the second page' do
    visit hungryform_path

    click_link 'Next'

    expect(page).to have_content 'Second'
  end
end