module HungryForm
  module Elements
    # Find a class of the Elements module by name
    def self.find_class(name)
      constants.find { |c| Class === const_get(c) && c.to_s.underscore.to_sym == name }
    end

    def self.all_classes
      constants.select { |c| Class === const_get(c) }
    end
  end
end

require_relative 'elements/base/hashable'
require_relative 'elements/base/element'
require_relative 'elements/base/active_element'
require_relative 'elements/base/options_element'
require_relative 'elements/base/group'
require_relative 'elements/page'
require_relative 'elements/group'
require_relative 'elements/html'
require_relative 'elements/text_field'
require_relative 'elements/select_field'
require_relative 'elements/text_area'
require_relative 'elements/checkbox_field'
require_relative 'elements/radio_group'
