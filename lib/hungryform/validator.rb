class HungryForm
  class Validator
    class << self
      def required(element, rule)
        if rule.respond_to? :call
          return rule.call(element)
        else
          return "is required" if element.value.to_s.empty? && rule
        end
      end
    end
  end
end