module StoreKit
  class ReceiptResponse
    attr_reader :receipt_data

    def initialize(receipt_data)
      @receipt_data = receipt_data
    end

    def latest_receipt
      Receipt.new(receipt_data['latest_receipt_info'] || {})
    end

    def receipt
      Receipt.new(receipt_data['receipt'] || {})
    end

    def iap_receipts
      @receipt_data['receipt']['in_app'] || []
    end

    def receipt_chains
      iap_receipts
        .group_by   { |receipt| receipt['original_transaction_id'] }
        .each_value { |chain| chain.sort_by! { |receipt| receipt['purchase_date_ms'].to_i } }
    end
  end
end
