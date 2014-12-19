module HungryForm
  module Helpers
    def link_to_hf_next_page(form, name, options = {}, &block)
      link_to_if form.next_page, name, form.next_page.name, options, &block
    end
  end
end