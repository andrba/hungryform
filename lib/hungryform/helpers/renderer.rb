module HungryForm
  class Renderer
    def initialize(template, options={})
      @template = template
    end

    def page_url(page)
      @template.url_for { page: page.name }
    end
  end
end