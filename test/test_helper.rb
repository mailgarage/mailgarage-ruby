# frozen_string_literal: true

require 'active_support'
require 'pry'

class Rails
  class << self
    attr_accessor :environment

    def env
      ActiveSupport::StringInquirer.new(environment)
    end

    def root
      Pathname.new('../')
    end
  end
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "mailgarage"

require "minitest/autorun"
require 'webmock/minitest'
require 'mail'

WebMock.disable_net_connect!
