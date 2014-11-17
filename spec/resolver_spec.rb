require "spec_helper"

describe HungryForm::Resolver do
  let(:resolver_params) { {:params => {}} }
  subject(:resolver) { HungryForm::Resolver.new(resolver_params) }

  describe ".get_value" do
    let(:element) { HungryForm::Html.new(:html_name, nil, resolver, { value: "value" }) {} }

    it "should get value from lambda param" do
      value = subject.get_value( ->(el){ "value" } )
      expect(value).to eq "value"
    end

    it "should get value from a form element" do
      subject.elements[element.name] = element
      expect(subject.get_value("html_name")).to eq "value"
    end

    it "should get value from a form params" do
      resolver_params[:params] = { "param1" => "param_value" }
      expect(subject.get_value("param1")).to eq "param_value"
    end

    it "should get value that equals the name" do
      expect(subject.get_value("name that doesn't exist")).to eq "name that doesn't exist"
    end
  end

  describe ".resolve_dependency" do
    it "should resolve EQ dependency" do
      dependency = { "EQ" => ["Text", "Text"] }
      expect(subject.resolve_dependency(dependency)).to eq true
    end

    it "should resolve LT dependency" do
      dependency = { "LT" => ["0", "1"] }
      expect(subject.resolve_dependency(dependency)).to eq true
    end

    it "should resolve GT dependency" do
      dependency = { "GT" => ["1", "0"] }
      expect(subject.resolve_dependency(dependency)).to eq true
    end 

    it "should resolve SET dependency" do
      dependency = { "SET" => "1" }
      expect(subject.resolve_dependency(dependency)).to eq true
    end 

    it "should resolve AND dependency" do
      dependency = { "AND" => [{"SET" => "1"}, {"SET" => "1"}] }
      expect(subject.resolve_dependency(dependency)).to eq true
    end

    it "should resolve OR dependency" do
      dependency = { "OR" => [{"SET" => ""}, {"SET" => "1"}] }
      expect(subject.resolve_dependency(dependency)).to eq true
    end

    it "should resolve NOT dependency" do
      dependency = { "NOT" => {"SET" => ""} }
      expect(subject.resolve_dependency(dependency)).to eq true
    end
  end
end