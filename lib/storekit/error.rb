module StoreKit
  class Error < ::StandardError
  end

  class ValidationError < Error
    attr_reader :status_code

    def initialize(status_code)
      @status_code = status_code
      message =
        case status_code
        when 21000 then 'The App Store could not read the JSON object you provided (21000).'
        when 21002 then 'The data in the receipt-data property was malformed or missing (21002).'
        when 21003 then 'The receipt could not be authenticated (21003).'
        when 21004 then 'The shared secret you provided does not match the shared secret on file for your account (21004).'
        when 21005 then 'The receipt server is not currently available (21005).'
        when 21006 then 'This receipt is valid but the subscription has expired (21006).'
        when 21007 then 'This receipt is from the test environment, but it was sent to the production environment for verification (21007).'
        when 21008 then 'This receipt is from the production environment, but it was sent to the test environment for verification (21008).'
        else 'Unknown error'
        end
      super(message)
    end

    def server_error?
      [21004, 21007, 21008].include?(status_code) || message == 'Unknown error'
    end

    def self.new status_code
      return super if self != ValidationError

      type =
        case status_code
        when 21000 then InvalidJsonError
        when 21002 then InvalidReceiptFormatError
        when 21003 then ReceiptAuthenticationError
        when 21004 then InvalidSharedSecretError
        when 21005 then ReceiptServerUnavailableError
        when 21006 then SubscriptionExpiredError
        when 21007 then TestEnvironmentRequiredError
        when 21008 then ProductionEnvironmentRequiredError
        end

      type.is_a?(NilClass) && super || type.new(status_code)
    end
  end

  class InvalidJsonError < ValidationError; end
  class InvalidReceiptFormatError < ValidationError; end
  class ReceiptAuthenticationError < ValidationError; end
  class InvalidSharedSecretError < ValidationError; end
  class ReceiptServerUnavailableError < ValidationError; end
  class SubscriptionExpiredError < ValidationError; end
  class TestEnvironmentRequiredError < ValidationError; end
  class ProductionEnvironmentRequiredError < ValidationError; end
end
