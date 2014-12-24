module HungryForm
  module ActionView
    def hungry_form_for(form, options={})
      params = get_params(options.delete(:params))
      params[:page] = form.current_page.name
      options[:rel] ||= "hungry-form-#{form.__id__}"

      views_prefix = options.delete(:views_prefix) || 'hungryform'

      form_tag(url_for(params), options) do
        render partial: "#{views_prefix}/form", locals: { form: form, views_prefix: views_prefix }
      end
    end

    def hungry_link_to_next_page(form, name, options={}, &block)
      params = get_params(options.delete(:params))
      method = options.delete(:method) || 'get'

      if method.to_s == 'get'
        params[:page] = form.next_page.try(:name) || ''
      else
        params[:page] = form.current_page.name
      end

      link_to_unless form.next_page.nil?, name, url_for(params), options.reverse_merge(rel: "hungry-form-#{form.__id__}", data: { form_method: method, form_action: :next }) do
        block.call if block
      end
    end

    def hungry_link_to_prev_page(form, name, options={}, &block)
      params = get_params(options.delete(:params))
      method = options.delete(:method) || 'get'

      if method.to_s == 'get'
        params[:page] = form.prev_page.try(:name) || ''
      else
        params[:page] = form.current_page.name
      end

      link_to_unless form.prev_page.nil?, name, url_for(params), options.reverse_merge(rel: "hungry-form-#{form.__id__}", data: { form_method: method, form_action: :prev }) do
        block.call if block
      end
    end

    def hungry_link_to_page(form, page, name, options={}, &block)
      params = get_params(options.delete(:params))
      method = options.delete(:method) || 'get'

      params[:page] = method.to_s == 'get' ? page.name : form.current_page.name

      link_to_if page.visible?, name, url_for(params), options.reverse_merge(rel: "hungry-form-#{form.__id__}", data: { form_method: method, form_action: :page }) do
        block.call if block
      end
    end

    def hungry_form_submit(form, name, options={})
    end

    private

    def get_params(params)
      exclude_params = :authenticity_token, :commit, :utf8, :_method
      self.params.except(*exclude_params).merge(params || {})
    end
  end
end
