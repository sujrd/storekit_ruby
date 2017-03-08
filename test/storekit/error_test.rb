require 'test_helper'

module StoreKit
  class ErrorTest < Test
    def test_error_subclases
      {
        21000 => InvalidJsonError,
        21002 => InvalidReceiptFormatError,
        21003 => ReceiptAuthenticationError,
        21004 => InvalidSharedSecretError,
        21005 => ReceiptServerUnavailableError,
        21006 => SubscriptionExpiredError,
        21007 => TestEnvironmentRequiredError,
        21008 => ProductionEnvironmentRequiredError,
      }.each do |status_code, error_class|
        err = ValidationError.new status_code
        assert_instance_of error_class, err
        assert_equal status_code, err.status_code
      end
    end
  end
end
