require "spec_helper"

describe "rendering text field", :if => defined?(Rails) do
  let(:attributes) { {} }
  let(:resolver) { HungryForm::Resolver.new }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, visible: true) {} }
  let(:text_field) { HungryForm::Elements::TextField.new(:field_name, group, resolver, attributes) }

  it "doesn't have a class attribute" do
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to start_with '<div>'
  end

  it "has an 'invalid' class attribute" do
    attributes.merge!(required: true, value:'')
    text_field.valid?
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to match /<div.*class="invalid"/
  end

  it "has a 'hidden' class attribute" do
    text_field.visible = false
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to match /<div.*class="hidden"/
  end

  it "doesn't have a data-dependency attribute" do
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to start_with '<div>'
  end

  it "has a data-dependency attribute" do
    attributes[:dependency] = '{"EQ":["1", "1"]}'
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to include 'data-dependency="{&quot;EQ&quot;:[&quot;1&quot;, &quot;1&quot;]}"'
  end

  it "has a label" do
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to include '<label for="group_field_name">Field name</label>'
  end

  it "has an asterisk if it is required" do
    attributes[:required] = true
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to include '<label for="group_field_name">Field name*</label>'
  end

  it "has an error message" do
    attributes[:required] = true
    text_field.valid?
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to include '<span class="error">This field is required</span>'
  end

  it "has an input" do
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to match /<input.*id="group_field_name"/
  end

  it "has an input with value" do
    attributes[:value] = 'default value'
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to match /<input.*value="default value"/
  end

  it "has an input with a class attribute" do
    attributes[:class] = 'my_class'
    render partial: "hungryform/text_field", locals: { field: text_field }
    expect(rendered).to match /<input.*class="my_class"/
  end
end