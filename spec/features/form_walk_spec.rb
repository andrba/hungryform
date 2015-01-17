require "spec_helper"

feature 'User clicks next on every page', :if => defined?(Rails), :js => true do
  before {
    allow_any_instance_of(HungryFormController).to receive(:form) do |controller|
      HungryForm::Form.new params: controller.params do
        page :first do
          text_field :field1, required: true
        end

        page :second do
          text_field :field2, required: true
        end

        page :third do
          text_field :field3, required: true
        end
      end
    end
  }

  scenario 'they visit the first page of the form' do
    visit hungryform_path

    expect(page).to have_content 'First'
    expect(page).to have_content 'Next'
  end

  scenario 'they see errors when they submit the first page of the form' do
    visit hungryform_path

    click_link 'Next'

    expect(page).to have_content 'This field is required'
  end

  scenario 'they successfully submit the first page of the form' do
    visit hungryform_path

    fill_in 'first_field1', with: 'field1 value'

    click_link 'Next'
    
    expect(page).to have_content 'Second'
    expect(page).to have_content 'Prev'
    expect(page).to have_content 'Next'
  end

  scenario 'they see errors when they submit the second page of the form' do
    visit hungryform_path(page: :second)

    click_link 'Next'

    expect(page).to have_content 'This field is required'
  end

  scenario 'they successfully submit the second page of the form' do
    visit hungryform_path(page: :second)

    fill_in 'second_field2', with: 'field2 value'

    click_link 'Next'

    expect(page).to have_content 'Third'
    expect(page).to have_content 'Prev'
  end

  scenario 'they are redirected to the first page that contains errors' do
    visit hungryform_path(page: :third)

    # Even though the page is valid, the previous pages are not
    fill_in 'third_field3', with: 'field3 value'

    click_link 'Submit'

    expect(page).to have_content 'First'
    expect(page).to have_content 'This field is required'
  end

  scenario 'they successfully submit the entire form' do
    visit hungryform_path(page: :third, first_field1: 'field1 value', second_field2: 'field2 value')

    fill_in 'third_field3', with: 'field3 value'
    click_link 'Submit'

    expect(page).to have_content 'The form has been submitted successfully'
  end

end
