RSpec.shared_examples 'it is wrapped in a div' do
  it "doesn't have a class attribute" do
    render render_params
    expect(rendered).not_to match /^<div.*class=/
  end

  it "has a 'hidden' class attribute" do
    field.visible = false
    render render_params
    expect(rendered).to match /<div.*class="hidden"/
  end

  it "doesn't have a data-dependency attribute" do
    render render_params
    expect(rendered).not_to match /^<div.*data-dependency=/
  end

  it "has a data-dependency attribute" do
    attributes[:dependency] = { eq: [1, 1] }
    render render_params
    expect(rendered).to include 'data-dependency="{&quot;eq&quot;:[1,1]}"'
  end

  it "has an id attribute" do
    render render_params
    expect(rendered).to include 'id="group_field_name_wrapper"'
  end
end