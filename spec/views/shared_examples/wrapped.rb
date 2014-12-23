RSpec.shared_examples 'it is wrapped in a div' do
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
end