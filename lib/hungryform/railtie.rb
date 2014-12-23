module HungryForm
  class Railtie < Rails::Railtie
    initializer 'hungryform' do
      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, HungryForm::ActionView
        Elements::Base::Element.send :include, Elements::Base::Renderable
      end
    end
  end
end