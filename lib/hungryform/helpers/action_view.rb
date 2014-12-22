module HungryForm
  module ActionView
    def hungry_form_for(form, options={})
      params = options.delete(:params) || {}
      params[:page] = form.current_page.name

      views_prefix = options.delete(:views_prefix) || 'hungryform'

      form_tag(url_for(params), options) do
        render partial: "#{views_prefix}/form", locals: { form: form, views_prefix: views_prefix }
      end
    end

    def hungry_link_to_next_page(form, name, options={}, &block)
      params = options.delete(:params) || {}
      method = params[:method] || 'get'

      if method.to_s == 'get'
        params[:page] = form.next_page.try(:name) || ''
      else
        params[:page] = form.current_page.name
      end

      link_to_unless form.next_page.nil?, name, url_for(params), options.reverse_merge(:rel => 'next', 'data-method' => method) do
        block.call if block
      end
    end

    def hungry_link_to_prev_page(form, name, options={}, &block)
      params = options.delete(:params) || {}
      method = params[:method] || 'get'

      if method.to_s == 'get'
        params[:page] = form.prev_page.try(:name) || ''
      else
        params[:page] = form.current_page.name
      end

      link_to_unless form.prev_page.nil?, name, url_for(params), options.reverse_merge(:rel => 'prev', 'data-method' => method) do
        block.call if block
      end
    end

    def hungry_link_to_page(form, page, name, options={}, &block)
      params = options.delete(:params) || {}
      method = params[:method] || 'get'

      params[:page] = method.to_s == 'get' ? page.name : form.current_page.name

      link_to_if page.visible?, name, url_for(params), options.reverse_merge(:rel => 'page', 'data-method' => method) do
        block.call if block
      end
    end

    def hungry_form_submit(form, name, options={})
    end
  end
end
