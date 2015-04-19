require "spec_helper"

describe HungryForm::Resolver do
  let(:resolver_params) { {:params => {}} }
  subject(:resolver) { HungryForm::Resolver.new(resolver_params) }
  let(:group_options) { {} }
  let(:group) { HungryForm::Elements::Group.new(:group, nil, resolver, group_options) {} }

  describe ".new" do
    it "should initialize resolver empty params" do
      expect(subject.params).to eq({})
    end

    it "should initialize resolver params" do
      resolver_params[:params] = {"key" => "value"}
      expect(subject.params).to eq({"key" => "value"})
    end
  end

  describe "#get_value" do
    let(:element) { HungryForm::Elements::Html.new(:html_name, group, subject, { value: "value" }) {} }

    it "should get value from lambda param" do
      value = subject.get_value( ->(el){ "value" } )
      expect(value).to eq "value"
    end

    it "should get value from a form element" do
      subject.elements[element.name] = element
      expect(subject.get_value("group_html_name")).to eq "value"
    end

    it "should get value from a form params" do
      resolver_params[:params] = { "param1" => "param_value" }
      expect(subject.get_value("param1")).to eq "param_value"
    end

    it "should get value that equals the name" do
      expect(subject.get_value("name that doesn't exist")).to eq "name that doesn't exist"
    end
  end

  describe "#resolve_dependency" do
    context "when dependency is of a scalar type" do
      it "should resolve EQ dependency" do
        dependency = { eq: ["Text", "Text"] }
        expect(subject.resolve_dependency(dependency)).to eq true
      end

      it "should resolve LT dependency" do
        dependency = { lt: ["0", "1"] }
        expect(subject.resolve_dependency(dependency)).to eq true
      end

      it "should resolve GT dependency" do
        dependency = { gt: ["1", "0"] }
        expect(subject.resolve_dependency(dependency)).to eq true
      end 

      it "should resolve SET dependency" do
        dependency = { set: "1" }
        expect(subject.resolve_dependency(dependency)).to eq true
      end

      it "should resolve AND dependency" do
        dependency = { and: [{set: "1"}, {set: "1"}] }
        expect(subject.resolve_dependency(dependency)).to eq true
      end

      it "should resolve OR dependency" do
        dependency = { or: [{set: ""}, {set: "1"}] }
        expect(subject.resolve_dependency(dependency)).to eq true
      end

      it "should resolve NOT dependency" do
        dependency = { not: {set: ""} }
        expect(subject.resolve_dependency(dependency)).to eq true
      end
    end
  end
end