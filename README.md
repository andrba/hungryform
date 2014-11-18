# HungryForm

HungryForm is a gem for managing multiple page forms. The main purpose of this gem is to give developers an easy DSL to build complex forms.

## Installation

Add this line to your application's Gemfile:

    gem 'hungryform'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hungryform

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

## Contributing

1. Fork it ( https://github.com/andrba/hungryform/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
