require "test_helper"

module Mailgarage
  class DeliveryMethodTest < Minitest::Test
    def setup
      stub_request(:post, "http://localhost:3001/emails")
        .to_return(status: 201)

      @mail = Mail.new(
        to: 'to@mailgarage.rocks',
        from: 'from@mailgarage.rocks',
        body: 'mailgarage email'
      )
    end

    def test_deliver_makes_api_request_in_production
      Rails.environment = 'production'
      response = Mailgarage::DeliveryMethod.new(api_key: 'test').deliver!(@mail)
      assert_equal response.code, '201'
    end

    def test_deliver_raises_in_production_with_no_api_key
      Rails.environment = 'production'
      assert_raises(Mailgarage::Error) { Mailgarage::DeliveryMethod.new.deliver!(@mail) }
    end
  end
end
