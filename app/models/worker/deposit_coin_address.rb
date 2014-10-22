module Worker
  class DepositCoinAddress

    def process(payload, metadata, delivery_info)
      payload.symbolize_keys!

      payment_address = PaymentAddress.find payload[:payment_address_id]
      return if payment_address.address.present?

      currency = payload[:currency]
      address  = CoinRPC[currency].getnewaddress("payment")
      payment_address.update address: address

      payment_address.trigger_deposit_address if payment_address.address_changed?
    end

  end
end
