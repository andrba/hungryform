require "spec_helper"

feature 'User activates dependency rules', :if => defined?(Rails), :js => true do
  before {
    allow_any_instance_of(HungryFormController).to receive(:form) do |controller, params|
      HungryForm::Form.new params: params do
        page :first do
          select_field :select_field, required: true, options: {
            show_textarea: "Show textarea",
            show_group: "Show group",
            second_page_visible: "Make second page visible"
          }

          text_area :textarea, dependency: { eq: ["first_select_field", "show_textarea"] }
          group :group, dependency: { eq: ["first_select_field", "show_group"] } do
            html :group_body, value: 'This is a group'
          end
        end

        page :second, dependency: { eq: ["first_select_field", "second_page_visible"] } do
          text_field :field2, required: true
        end

        page :third do
          html :last_page, value: 'This is the last page'
        end
      end
    end
  }

  scenario 'they see textarea' do
    visit hungryform_path
    expect(page).not_to have_content 'Textarea'
    select("Show textarea", :from => 'first_select_field')
    expect(page).to have_content 'Textarea'
  end

  scenario 'they see group' do
    visit hungryform_path
    expect(page).not_to have_content 'This is a group'
    select("Show group", :from => 'first_select_field')
    expect(page).to have_content 'This is a group'
  end

  scenario 'they see the second page' do
    visit hungryform_path
    select("Make second page visible", :from => 'first_select_field')
    click_link 'Next'
    expect(page).to have_content 'Second'
  end
end
