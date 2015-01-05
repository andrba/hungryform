require "spec_helper"

feature 'User clicks next', :if => defined?(Rails), :js => true do
  before {
    allow_any_instance_of(HungryFormController).to receive(:form) do |controller|
      HungryForm::Form.new params: controller.params do
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

    fill_in 'Field1', with: 'field1 value'

    click_link 'Next'
    # save_and_open_page
    expect(page).to have_content 'Second'
  end
end