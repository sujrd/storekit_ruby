require 'ostruct'

module StoreKit
  class Receipt < OpenStruct
    TRANSFORM = {
       'unique_identifier' => true,
       'product_id' => true,
       'bid' => true,
       'unique_vendor_identifier' => true,
       'bvrs' => true,
       'transaction_id' => proc { |v| v.to_i },
       'original_transaction_id' => proc { |v| v.to_i },
       'quantity' => proc { |v| v.to_i },
       'item_id' => proc { |v| v.to_i },
       'web_order_line_item_id' => proc { |v| v.to_i },
       'original_purchase_date_ms' => proc { |v| Time.at(v.to_f / 1_000) },
       'purchase_date_ms' => proc { |v| Time.at(v.to_f / 1_000) },
       'expires_date' => proc { |v| Time.at(v.to_f / 1_000) },
    }

    def self.parse receipt_data
      TRANSFORM.reduce(Receipt.new) do |struct, (prop, value)|
        case value
        when TrueClass
          struct.send("#{prop}=", receipt_data[prop])
        when Proc
          struct.send("#{prop}=", value[receipt_data[prop]])
        end

        struct
      end
    end

    def initialize receipt_data = nil
      if receipt_data.is_a?(Hash)
        super(self.class.parse(receipt_data).to_h)
      else
        super()
      end
    end
  end
end
