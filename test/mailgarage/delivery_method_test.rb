require "test_helper"

module Mailgarage
  class DeliveryMethodTest < Minitest::Test
    def setup
      stub_request(:post, "https://mailgarage.rocks/emails")
        .to_return(status: 201)

      @mail = Mail.new(
        to: 'to@mailgarage.rocks',
        from: 'from@mailgarage.rocks',
        body: 'mailgarage email'
      )
    end

    def test_deliver_makes_api_request_in_production
      Rails.environment = 'production'
      Mailgarage.configure { |c| c.api_key = 'test' }
      response = Mailgarage::DeliveryMethod.new.deliver!(@mail)
      assert_equal response.code, '201'
    end

    def test_deliver_raises_in_production_with_no_api_key
      Rails.environment = 'production'
      Mailgarage.configure { |c| c.api_key = nil }
      assert_raises(Mailgarage::Error) { Mailgarage::DeliveryMethod.new.deliver!(@mail) }
    end

    def test_deliver_raises_in_test
      Rails.environment = 'test'
      assert_raises(Mailgarage::Error) { Mailgarage::DeliveryMethod.new.deliver!(@mail) }
    end
  end
end
