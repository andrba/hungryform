class HungryForm
  # Page is a main element of a form.
  # Each page can include a page structure, defined in the block
  # 
  # A sample page could look like this:
  #   page :about do
  #     html :before, "Please fill out the following fields"
  #     text_field :first_name
  #     text_field :last_name
  #   end
  # 
  # The only required argument of a page is its name.
  # You can specify a title and a label in the options like this:
  # 
  # page :about, title: "About me", label: "About"
  # 
  # If there is no title or label specified, they will be created
  # from the :name argument
  class Page < BaseGroup
    attr_accessor :title, :label

    def initialize(name, options = {}, resolver, &block)
      @label = options[:label] || name.to_s.humanize
      @title = options[:title] || @label

      super
    end
  end
end