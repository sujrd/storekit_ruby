module StoreKit
  class Receipt
    attr_reader :receipt_data

    def initialize(receipt_data)
      @receipt_data = receipt_data
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
