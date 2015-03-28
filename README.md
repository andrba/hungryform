# HungryForm [![Build Status](https://travis-ci.org/andrba/hungryform.svg?branch=master)](https://travis-ci.org/andrba/hungryform) [![Code Climate](https://codeclimate.com/github/andrba/hungryform/badges/gpa.svg)](https://codeclimate.com/github/andrba/hungryform)

HungryForm is a gem for managing multiple page forms. The main purpose of this gem is to give developers an easy DSL to build complex forms. 

## Usage

```ruby
form = HungryForm::Form.new do
  page :first do
    text_field :first_name, required: true
    text_field :last_name, required: true
  end
  page :second, do 
    text_field :address
    select_field :gender, options: { "M" => "Male", "F" => "Female" }, required: true
  end
  page :third do 
    text_field :occupation
    
    # Show this group only when the occupation field is not empty
    group :employment_history, dependency: { set: "third_occupation" } do
      html :before, value: "Employment history over the last 5 years"
      text_area :history, value: "Default value"
    end
  end 
end

if form.valid?
  form.to_json
end
```

## Rails Installation

Add the ```hungryform``` gem to your Gemfile:

```ruby
gem "hungryform"
```

Add the Hungryform require to your application.js:

```javascript
//= require hungryform
```

Add the Hungryform require to your application.css:

```css
//= require hungryform
```

Use the following helper to generate the form in your views:

```ruby
<%= hungry_form_for(@form) %>
```

You can redefine the field templates by creating your own ones in the views/hungryform folder.

## Field Dependencies

Each element of HungryForm, including pages and groups, can have a ```dependency``` parameter. This parameter must be a hash, containing a tree of basic operations. The dependency tree eventually resolves into to a boolean result. Within this tree you can use and combine the following operators, creating complex dependencies that can involve multiple elements:

```ruby
# val1 == val2
{ eq: ["val1", "val2"] }

# val1 > val2
{ gt: ["val1", "val2"] }

# val1 < val2
{ lt: ["val1", "val2"] }

# val1 is not empty
{ set: "val1" }

# Get the opposite result of the expression
{ not: { eq: [1, 1] } }

# Check if all the expressions are true
{ 
  and: [
    { eq: [1, 1] },
    { eq: [2, 2] }
  ] 
}

# Check if any of the expressions is true
{ 
  or: [
    { not: { eq: [1, 1] } },
    { eq: [2, 2] }
  ] 
}
```

If the dependency is resolved positively it makes the element visible. Otherwise the element will be hidden and not required. It is allowed to use element names or params keys as parameters inside expressions.

```ruby
HungryForm::Form.new do
  page :about do
    text_field :age
    text_field :favourite_alcohol, required: true, dependency: { gt: ["about_age", 18] }
  end
end
    
```

## Assigning values

To assign values to form fields pass them as a hash on form initialization. The params hash must consist of field names and their values. Please note, that the field names must contain the full path to the field, starting from the page name.

```ruby
params = {
  "first_first_name" => "John",
  "first_last_name" => "Doe",
  "second_address" => "John's address",
  "third_occupation" => "Software engineer",
  "third_employment_history_history" => "John's employment history"
}

form = HungryForm::Form.new :params => params do
...
end

```

You can assign default value to a form field:

```ruby
text_field :email, value: "john.doe@yahoo.com"
```

## Validation

Each active element of a form can be assigned with validation rules.

- required - accepts boolean or proc
- validation - accepts proc

```ruby
text_field :name, required: true
text_field :email, validation: ->(el) { "is unexpected email" unless el.value == "me@yahoo.com"  }
```

You can extend the list of validation rules by creating your own validation methods:

```ruby
module HungryForm
  module Validator
    class << self
      def my_validation_method(element, rule)
        "is not #{rule}" unless element.value == rule
      end
    end
  end
end
  
  
text_field :vegetable, value: "tomato", my_validation_method: "potato" # => is not potato
```

## Custom form fields
You can create your own field type by adding a new class into the HungryForm::Elements module. There are three base classes that you can choose to inherit from:

- Base::Element - use this class when you don't need the field to have a value and validation. As an example it can be used for text/html output
- Base::ActiveElement - use this class when you need the field to have a value and validation
- Base::OptionsElement - this class inherits the Base::ActiveElement. Use it when you need to create an element with an options hash, like a dropdown

```ruby
module HungryForm
  module Elements
    class MyField < Base::ActiveElement
      attr_accessor :my_param

      hashable :my_param
      
      def initialize(name, parent, resolver, options = {}, &block)
        self.my_param = options[:my_param] || true
        
        super
      end
      
      def valid?
        self.value == 'valid_value'
      end
    end
  end
end

form = HungryForm::Form.new do
  page :main do
    my_field :my_field_name, my_param: "Param Value"
  end
end
```

## Contributing

1. Fork it ( https://github.com/andrba/hungryform/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
