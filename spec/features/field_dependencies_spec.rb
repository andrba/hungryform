require "spec_helper"

feature 'User activates dependency rules', :if => defined?(Rails), :js => true do
  before {
    allow_any_instance_of(HungryFormController).to receive(:form) do |controller|
      HungryForm::Form.new params: controller.params do
        page :first do
          select_field :select_field, required: true, options: {
            show_textarea: "Show textarea",
            show_group: "Show group",
            second_page_visible: "Make second page visible"
          }

          text_area :textarea, dependency: '{"EQ": ["first_select_field", "show_textarea"]}'
          group :group, dependency: '{"EQ": ["first_select_field", "show_group"]}' do
            html :group_body, value: 'This is a group'
          end
        end

        page :second, dependency: '{"EQ": ["first_select_field", "second_page_visible"]}' do
          text_field :field2, required: true
        end
      end
    end
  }

  scenario 'they see textarea' do
    visit hungryform_path
    save_and_open_page
    select("Show textarea", :from => 'first_select_field')
    expect(page).to have_content 'Textarea'
  end
end
