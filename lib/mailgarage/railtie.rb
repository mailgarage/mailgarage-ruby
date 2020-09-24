module Mailgarage
  class Railtie < Rails::Railtie
    initializer 'mailgarage.delivery_method_initializer' do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method(:mailgarage, Mailgarage::DeliveryMethod)
      end
    end
  end
end
