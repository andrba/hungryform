RSpec.shared_examples 'it is wrapped in a div' do
  context 'when it is required' do
    before(:each) { attributes[:required] = true }

    it "has an 'invalid' class attribute" do
      field.valid?
      render render_params
      expect(rendered).to match /<div.*class="invalid"/
    end

    it "has an asterisk in a label" do
      render render_params
      expect(rendered).to include '<label for="group_field_name">Field name*</label>'
    end

    it "has an error message" do
      field.valid?
      render render_params
      expect(rendered).to include '<span class="error">This field is required</span>'
    end
  end

  it "doesn't have a class attribute" do
    render render_params
    expect(rendered).to start_with '<div>'
  end

  it "has a 'hidden' class attribute" do
    field.visible = false
    render render_params
    expect(rendered).to match /<div.*class="hidden"/
  end

  it "doesn't have a data-dependency attribute" do
    render render_params
    expect(rendered).to start_with '<div>'
  end

  it "has a data-dependency attribute" do
    attributes[:dependency] = '{"EQ":["1", "1"]}'
    render render_params
    expect(rendered).to include 'data-dependency="{&quot;EQ&quot;:[&quot;1&quot;, &quot;1&quot;]}"'
  end

  it "has a label" do
    render render_params
    expect(rendered).to include '<label for="group_field_name">Field name</label>'
  end
end