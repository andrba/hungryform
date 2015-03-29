require "spec_helper"

describe HungryForm do
  let(:options) do
    {
      :params => {
        "first_first_name" => "John", 
        "first_last_name" => "Doe", 
        "second_email" => "john.doe@yahoo.com", 
        "third_occupation" => "programmer"
      } 
    } 
  end

  subject do
    HungryForm::Form.new(options) do
      page :first do
        text_field :first_name, required: true
        text_field :last_name
      end
      page :second, visible: false do 
        text_field :email
      end
      page :third do 
        select_field :occupation, :options => {"programmer" => "Programmer", "other" => "Other"}
        group :employment_history do
          html :before, value: "Employment history over the last 5 years"
          text_field :history, value: "Default value"
        end
      end
    end 
  end

  describe ".new" do
    it "should contain pages" do
      expect(subject.pages.size).to eq 2
    end
  end

  describe ".configure" do
    it "sets a new views prefix" do
      HungryForm.configure do |config|
        config.views_prefix = '/new/prefix'
      end

      expect(HungryForm.configuration.views_prefix).to eq '/new/prefix'
    end

    it "configures default element options" do
      HungryForm.configure do |config|
        config.text_field["data-length"] = 100
      end

      expect(HungryForm.configuration.text_field["data-length"]).to eq 100
    end

    after do
      HungryForm.reset_config
    end
  end

  describe "#page" do 
    subject(:form) { HungryForm::Form.new() {} }

    it "should contain a page" do
      form.page(:page_name, {}) {}
      expect(form.pages.first.class).to eq HungryForm::Elements::Page
    end
  end

  describe "#to_json" do
    it "should create a json string from the form objects" do
      hash = JSON.parse(subject.to_json)
      expect(hash["pages"].size).to eq 2
      expect(hash["pages"].first["elements"].size).to eq 2
    end
  end

  describe "#values" do
    it "should generate an array of name => value hashes" do
      expect(subject.values).to include(
        first_first_name: "John",
        first_last_name: "Doe",
        third_occupation: "programmer"
      )
    end
  end

  describe "#valid?" do
    it "should be valid" do
      expect(subject.valid?).to eq true
    end

    it "should be invalid" do
      options[:params]["first_first_name"] = ''
      expect(subject.valid?).to eq false
    end
  end

  describe "#next_page" do
    it "should return the next page" do
      options[:params][:page] = "first"
      expect(subject.next_page).to eq subject.pages[1]
    end

    it "should return nil if there is no next page" do
      options[:params][:page] = "third"
      expect(subject.next_page).to be_nil
    end
  end

  describe "#prev_page" do
    it "should return the previous page" do
      options[:params][:page] = "third"
      expect(subject.prev_page).to eq subject.pages.first
    end

    it "should return nil if there is no previous page" do
      options[:params][:page] = "first"
      expect(subject.prev_page).to be_nil
    end
  end
end