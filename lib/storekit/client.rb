module StoreKit
  SANDBOX_HOST = 'sandbox.itunes.apple.com'
  PRODUCTION_HOST = 'buy.itunes.apple.com'

  class Client
    attr_accessor :shared_secret

    def self.sandbox
      new(SANDBOX_HOST)
    end

    def self.production
      new(PRODUCTION_HOST)
    end

    def initialize(host)
      @http = Net::HTTP.new host, 443
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    def verify!(base64_payload)
      payload = {'receipt-data' => base64_payload}
      payload['password'] = shared_secret if shared_secret

      req = Net::HTTP::Post.new '/verifyReceipt'
      req.body = JSON.generate payload
      resp = @http.request(req)

      decoded = JSON.parse resp.body

      if decoded['status'] == 0
        Receipt.new decoded
      else
        raise ValidationError.new decoded['status']
      end
    end
  end
end
