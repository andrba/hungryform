module HungryForm
  module ActionView
    # Render a form
    def hungry_form_for(form, options={})
      options[:rel] ||= "hungry-form-#{form.__id__}"

      views_prefix = options.delete(:views_prefix) || 'hungryform'

      form_tag('', options) do
        render partial: "#{views_prefix}/form", locals: { form: form, views_prefix: views_prefix }
      end
    end

    # Render a link to the next page
    # If a form is on its last page - render nothing
    def hungry_link_to_next_page(form, name, options={}, &block)
      params = clean_params(options.delete(:params))
      method = options.delete(:method) || 'get'

      params[:page] = get_page(form, method, :next_page)
      
      unless form.next_page.nil?
        link_to name, url_for(params), build_options(options, form, method, :next), &block
      end
    end

    # Render a link to the previous page
    # If a form is on its first page - render nothing
    def hungry_link_to_prev_page(form, name, options={}, &block)
      params = clean_params(options.delete(:params))
      method = options.delete(:method) || 'get'

      params[:page] = get_page(form, method, :prev_page)

      unless form.prev_page.nil?
        link_to name, url_for(params), build_options(options, form, method, :prev), &block
      end
    end

    # Render a link to a provided page
    # If the page is not visible - render nothing
    def hungry_link_to_page(form, page, name, options={}, &block)
      params = clean_params(options.delete(:params))
      method = options.delete(:method) || 'get'

      params[:page] = method.to_s == 'get' ? page.name : form.current_page.name

      if page.visible?
        link_to name, url_for(params), build_options(options, form, method, :page), &block
      end
    end

    def hungry_form_submit(form, name, options={})
    end

    private

    # Remove Rails specific params from the params hash
    def clean_params(params)
      exclude_params = :authenticity_token, :commit, :utf8, :_method
      self.params.except(*exclude_params).merge(params || {})
    end

    # Build link_to options
    def build_options(options, form, method, action)
      options.reverse_merge(
        rel: "hungry-form-#{form.__id__}", 
        data: { form_method: method, form_action: action }
      )
    end

    # Get the previous or the next page of the form
    def get_page(form, method, direction_method)
      if method.to_s == 'get'
        form.send(direction_method).try(:name) || ''
      else
        form.current_page.name
      end
    end
  end
end
