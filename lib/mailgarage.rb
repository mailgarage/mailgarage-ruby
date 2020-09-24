require 'letter_opener'

require "mailgarage/version"
require 'mailgarage/delivery_method'

module Mailgarage
  class Error < StandardError; end
end

raise(Mailgarage::Error, 'This gem can only be used with Rails') unless defined?(Rails)

require 'mailgarage/railtie' if defined?(Rails::Railtie)
