# frozen_string_literal: true

module Mailgarage
  autoload :Configuration, 'mailgarage/configuration'
  autoload :DeliveryMethod, 'mailgarage/delivery_method'
  class Error < StandardError; end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end

raise(Mailgarage::Error, 'This gem can only be used with Rails') unless defined?(Rails)

require 'mailgarage/railtie' if defined?(Rails::Railtie)
require 'letter_opener'
