# frozen_string_literal: true

module Mailgarage
  class DeliveryMethod
    def initialize(options = {})
      @settings = options
      @api_key = Mailgarage.configuration.api_key
    end

    def deliver!(mail)
      @mail = mail

      case Rails.env
      when 'development'
        deliver_in_development
      when 'production'
        deliver_in_production
      when 'test'
        deliver_in_test
      else # any arbitrary env like staging
        deliver_in_production
      end
    end
    
    def deliver_in_production
      raise(Mailgarage::Error, "We can't send emails in #{Rails.env} without api_key set.") unless @api_key

      uri = URI.parse('https://mailgarage.rocks')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new('/emails')
      request.body = { email: @mail.to_s, environment: Rails.env }.to_json
      request['Content-Type'] = 'application/json'
      request['Api-Key'] = @api_key
      http.request(request)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      raise(Mailgarage::Error, "Error from Net::HTTP: #{e.message}")
    end

    def deliver_in_development
      LetterOpener::DeliveryMethod.new(
        message_template: 'light',
        location: Rails.root.join('tmp', 'mailgarage')
      )
      .deliver!(@mail)
    end

    def deliver_in_test
      raise(Mailgarage::Error, 'You should set config.mail_delivery to :test in your environment config so you can test your email delivery.')
    end
  end
end
