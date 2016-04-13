module StoreKit
  class Error < ::StandardError
  end

  class ValidationError < Error
    attr_reader :status_code

    def initialize(status_code)
      @status_code = status_code
      message =
        case status_code
        when 21000 then 'The App Store could not read the JSON object you provided.'
        when 21002 then 'The data in the receipt-data property was malformed or missing.'
        when 21003 then 'The receipt could not be authenticated.'
        when 21004 then 'The shared secret you provided does not match the shared secret on file for your account.'
        when 21005 then 'The receipt server is not currently available.'
        when 21006 then 'This receipt is valid but the subscription has expired.'
        when 21007 then 'This receipt is from the test environment, but it was sent to the production environment for verification.'
        when 21008 then 'This receipt is from the production environment, but it was sent to the test environment for verification.'
        else 'Unknown error'
        end
      super(message)
    end

    def server_error?
      [21004, 21007, 21008].include?(status_code) || message == 'Unknown error'
    end
  end
end
