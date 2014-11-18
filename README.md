# HungryForm

HungryForm is a gem for managing multiple page forms. The main purpose of this gem is to give developers an easy DSL to build complex forms.

## Usage

```ruby
require 'hungryform'

form = HungryForm.new do
  page :first do
    text_field :first_name
    text_field :last_name
  end
  page :second, do 
    text_field :address
  end
  page :third do 
    text_field :occupation
    
    # Show this group only when the occupation field is not empty
    group :employment_history, visible: false, dependency: '{"SET": "third_occupation"}' do
      html :before, value: "Employment history over the last 5 years"
      text_field :history, value: "Default value"
    end
  end 
end
```

To assign values to the form elements pass them as a hash on form initialization

```ruby
params = {
  "first_first_name" => "John",
  "first_last_name" => "Doe",
  "second_address" => "John's address",
  "third_occupation => "Software engineer",
  "third_employment_history_history" => "John's employment hisotory"
}

form = HungryForm.new :params => params do
...
end

```


## Validation

Each active element of a form can be assigned with validation rules.

- required - accepts boolean or proc
- validation - accepts proc

```ruby
text_field :name, required: true
text_field :email, validation: ->(el) { "is unexpected email" unless el.value == "me@yahoo.com"  }
```

You can extend the list of validation rules by opening the HungryForm::Validator singleton class and creating your own validation methods:

```ruby
class HungryForm
  class Validator
    class << self
      def my_validation_method(element, rule)
        "is not #{rule}" unless element.value == rule
      end
    end
  end
end
  
  
text_field :vegetable, value: "tomato", my_validation_method: "potato" # => is not potato
```

## Contributing

1. Fork it ( https://github.com/andrba/hungryform/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
