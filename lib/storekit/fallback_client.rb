module StoreKit
  class FallbackClient
    attr_accessor :shared_secret

    def verify!(base64_payload)
      client = Client.production
      client.shared_secret = shared_secret
      client.verify! base64_payload
    rescue ValidationError => err
      raise err unless err.status_code == 21007
      client = Client.sandbox
      client.shared_secret = shared_secret
      client.verify! base64_payload
    end
  end
end
