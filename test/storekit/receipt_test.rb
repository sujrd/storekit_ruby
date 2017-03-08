require 'test_helper'

module StoreKit
  class ReceiptTest < Test

    def test_get_iap_receipts
      data = single_purchase_receipt_data
      receipt = Receipt.new data
      assert_respond_to receipt, :iap_receipts
      assert_equal data['receipt']['in_app'], receipt.iap_receipts
    end

    def test_get_receipt_chains
      receipt = Receipt.new recurring_purchases_receipt_data
      assert_respond_to receipt, :receipt_chains

      chains = receipt.receipt_chains
      # The keys are the original transaction ID
      assert chains.has_key? '1000000165289217'
      assert chains.has_key? '1000000165289219'

      assert_equal 2, chains['1000000165289217'].size
      assert_equal 1, chains['1000000165289219'].size
    end

    def test_individual_receipt_chain_transactions_sorted_by_purchase_date
      receipt = Receipt.new recurring_purchases_receipt_data
      chains = receipt.receipt_chains

      expected_tx_id_order = ['1000000165289944', '1000000165290338']
      assert_equal expected_tx_id_order, chains['1000000165289217'].map{ |tx| tx['transaction_id'] }
    end

    private

    def single_purchase_receipt_data
      {
        "status" => 0,
        "environment" => "Sandbox",
        "receipt" => {
          "receipt_type" => "ProductionSandbox",
          "adam_id" => 0,
          "app_item_id" => 0,
          "bundle_id" => "com.example.FakeApp",
          "application_version" => "5",
          "download_id" => 0,
          "version_external_identifier" => 0,
          "request_date" => "2015-07-29 00:30:46 Etc/GMT",
          "request_date_ms" => "1438129846850",
          "request_date_pst" => "2015-07-28 17:30:46 America/Los_Angeles",
          "original_purchase_date" => "2013-08-01 07:00:00 Etc/GMT",
          "original_purchase_date_ms" => "1375340400000",
          "original_purchase_date_pst" => "2013-08-01 00:00:00 America/Los_Angeles",
          "original_application_version" => "1.0",
          "in_app" => [{
            "quantity" => "1",
            "product_id" => "com.example.FakeApp.Product1",
            "transaction_id" => "1000000165471599",
            "original_transaction_id" => "1000000165471599",
            "purchase_date" => "2015-07-29 01:31:33 Etc/GMT",
            "purchase_date_ms" => "1438133493000",
            "purchase_date_pst" => "2015-07-28 18:31:33 America/Los_Angeles",
            "original_purchase_date" => "2015-07-29 01:31:33 Etc/GMT",
            "original_purchase_date_ms" => "1438133493000",
            "original_purchase_date_pst" => "2015-07-28 18:31:33 America/Los_Angeles",
            "is_trial_period" => "false"
          }]
        }
      }
    end

    def recurring_purchases_receipt_data
      {
        "status" => 0,
        "environment" => "Sandbox",
        "receipt" => {
          "receipt_type" => "ProductionSandbox",
          "adam_id" => 0,
          "app_item_id" => 0,
          "bundle_id" => "com.manabook.FakeApp",
          "application_version" => "5",
          "download_id" => 0,
          "version_external_identifier" => 0,
          "request_date" => "2015-07-29 00:30:46 Etc/GMT",
          "request_date_ms" => "1438129846850",
          "request_date_pst" => "2015-07-28 17:30:46 America/Los_Angeles",
          "original_purchase_date" => "2013-08-01 07:00:00 Etc/GMT",
          "original_purchase_date_ms" => "1375340400000",
          "original_purchase_date_pst" => "2013-08-01 00:00:00 America/Los_Angeles",
          "original_application_version" => "1.0",
          "in_app" => [{
            "quantity" => "1",
            "product_id" => "com.example.FakeApp.Product2",
            "transaction_id" => "1000000165290338",
            "original_transaction_id" => "1000000165289217",
            "purchase_date" => "2015-07-28 01:44:38 Etc/GMT",
            "purchase_date_ms" => "1438047878000",
            "purchase_date_pst" => "2015-07-27 18:44:38 America/Los_Angeles",
            "original_purchase_date" => "2015-07-28 01:42:39 Etc/GMT",
            "original_purchase_date_ms" => "1438047759000",
            "original_purchase_date_pst" => "2015-07-27 18:42:39 America/Los_Angeles",
            "expires_date" => "2015-07-28 01:49:38 Etc/GMT",
            "expires_date_ms" => "1438048178000",
            "expires_date_pst" => "2015-07-27 18:49:38 America/Los_Angeles",
            "web_order_line_item_id" => "1000000030215909",
            "is_trial_period" => "false"
          }, {
            "quantity" => "1",
            "product_id" => "com.example.FakeApp.Product2",
            "transaction_id" => "1000000165289944",
            "original_transaction_id" => "1000000165289217",
            "purchase_date" => "2015-07-28 01:39:38 Etc/GMT",
            "purchase_date_ms" => "1438047578000",
            "purchase_date_pst" => "2015-07-27 18:39:38 America/Los_Angeles",
            "original_purchase_date" => "2015-07-28 01:37:43 Etc/GMT",
            "original_purchase_date_ms" => "1438047463000",
            "original_purchase_date_pst" => "2015-07-27 18:37:43 America/Los_Angeles",
            "expires_date" => "2015-07-28 01:44:38 Etc/GMT",
            "expires_date_ms" => "1438047878000",
            "expires_date_pst" => "2015-07-27 18:44:38 America/Los_Angeles",
            "web_order_line_item_id" => "1000000030215898",
            "is_trial_period" => "false"
          }, {
            "quantity" => "1",
            "product_id" => "com.example.FakeApp.Product3",
            "transaction_id" => "1000000165289217",
            "original_transaction_id" => "1000000165289219",
            "purchase_date" => "2015-07-28 01:34:38 Etc/GMT",
            "purchase_date_ms" => "1438047278000",
            "purchase_date_pst" => "2015-07-27 18:34:38 America/Los_Angeles",
            "original_purchase_date" => "2015-07-28 01:34:39 Etc/GMT",
            "original_purchase_date_ms" => "1438047279000",
            "original_purchase_date_pst" => "2015-07-27 18:34:39 America/Los_Angeles",
            "expires_date" => "2015-07-28 01:39:38 Etc/GMT",
            "expires_date_ms" => "1438047578000",
            "expires_date_pst" => "2015-07-27 18:39:38 America/Los_Angeles",
            "web_order_line_item_id" => "1000000030215897",
            "is_trial_period" => "false"
          }]
        }
      }
    end
  end

  class ErrorTest < Test
    def test_exceptions
      err_codes = [21000, 21002, 21003, 21004, 21005, 21006, 21007, 21008]
      classes = %w(
        InvalidJsonError
        InvalidReceiptFormatError
        ReceiptAuthenticationError
        InvalidSharedSecretError
        ReceiptServerUnavailableError
        SubscriptionExpiredError
        TestEnvironmentRequiredError
        ProductionEnvironmentRequiredError)

      err_codes.each.with_index do |code, i|
        receipt = ValidationError.new(code)
        assert_equal receipt.class.to_s, "StoreKit::#{classes[i]}"
      end
    end
  end
end
