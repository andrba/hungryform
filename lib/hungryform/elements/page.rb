class HungryForm
  module Elements
    # Page is a main element of a form.
    # Each page can include a page structure, defined in the block
    #
    # A sample page could look like this:
    #   page :about do
    #     html :before, value: "Please fill out the following fields"
    #     text_field :first_name
    #     text_field :last_name
    #   end
    #
    # The only required argument of a page is its name.
    # You can specify a title and a label in the attributes like this:
    #
    # page :about, title: "About me", label: "About"
    #
    # If there is no title or label specified, they will be created
    # from the :name argument
    class Page < Base::Group
      attr_accessor :title

      hashable :title

      def initialize(name, parent, resolver, attributes = {}, &block)
        super
        self.title ||= label
      end
    end
  end
end
