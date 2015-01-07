module HungryForm
  module ActionView
    # Render a form
    def hungry_form_for(form, options = {})
      options[:data] ||= {}
      options[:data][:rel] ||= form_rel(form)

      views_prefix = options.delete(:views_prefix) || 'hungryform'

      form_tag('', options) do
        render partial: "#{views_prefix}/form", locals: {
          form: form,
          views_prefix: views_prefix
        }
      end
    end

    # Render a link to the next page
    def hungry_link_to_next_page(form, name, options = {}, &block)
      link_to name, *link_params(form, options, action: :next), &block
    end

    # Render a link to the previous page
    def hungry_link_to_prev_page(form, name, options = {}, &block)
      link_to name, *link_params(form, options, action: :prev), &block
    end

    # Render a link to a provided page
    def hungry_link_to_page(form, page, options = {}, &block)
      link_to page.label, *link_params(form, options, action: :page, page: page), &block
    end

    # Render a link that submits the form
    def hungry_link_to_submit(form, name, options = {}, &block)
      params = clean_params(options.delete(:params))

      link_to name, url_for(params), options.reverse_merge(
        data: { form_method: :post, form_action: :submit, rel: form_rel(form) }
      ), &block
    end

    private

    # Builds link_to params except for the link's name
    def link_params(form, options, action_options = {})
      method = options.delete(:method) || 'get'
      params = clean_params(options.delete(:params))

      params[:page] = method.to_s == 'get' ? get_page(form, action_options) : form.current_page.name

      options.reverse_merge!(
        data: {
          form_method: method,
          form_action: action_options[:action],
          rel: form_rel(form)
        }
      )

      [url_for(params), options]
    end

    # Find the name of the page to go to when the 'get' method is used in a
    # form navigation
    def get_page(form, action_options)
      case action_options[:action]
      when :page
        action_options[:page].name
      else
        form.send("#{action_options[:action]}_page").try(:name) || ''
      end
    end

    # Form ralation attribute is used to streamline js selection of a form
    # and its navigational elements like next/prev buttons and pages lists
    def form_rel(form)
      "hungry-form-#{form.__id__}"
    end

    # Remove Rails specific params from the params hash
    def clean_params(params)
      exclude_params = :authenticity_token, :commit, :utf8, :_method
      self.params.except(*exclude_params).merge(params || {})
    end
  end
end
