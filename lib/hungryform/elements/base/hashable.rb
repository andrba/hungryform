module HungryForm
  module Elements
    module Base
      # This module adds hashing capabilities to form elements.
      # Do not include this module in your classes. It is already
      # included in the base_element class.
      #
      # Sample usage:
      #
      # class MyField
      #   attr_accessor :param1, :param2
      #   hashable :param1, :param2
      #   ...
      # end
      #
      # Any instance of MyField class will have the "to_hash" method
      # that will contain only the accessor/reader params defined in
      # the hashable macro.
      module Hashable
        def self.included(base)
          base.extend ClassMethods
          base.class_attribute :hashable_attributes
          base.hashable_attributes = []
        end

        def to_hash
          hash = self.class.hashable_attributes.each_with_object({}) do |param, h|
            h[param] = send(param) unless send(param).nil?
          end
          hash.merge(_type: self.class.name.demodulize)
        end

        module ClassMethods
          def hashable(*params)
            self.hashable_attributes = hashable_attributes.dup.concat params
          end
        end
      end
    end
  end
end
