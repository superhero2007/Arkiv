module Deposits
  module CtrlBankable
    extend ActiveSupport::Concern

    included do
      before_filter :fetch
    end

    def create
      Rails.logger.debug "Deposit parameters #{deposit_params}"
      @deposit = Deposit.new(deposit_params)

      if @deposit.save
        render nothing: true
      else
        render text: @deposit.errors.full_messages.join, status: 403
      end
    end

    def destroy
      @deposit = current_user.deposits.find(params[:id])
      @deposit.cancel!
      render nothing: true
    end

    private

    def fetch
      @account = current_user.get_account(channel.currency)
      @model = model_kls
      @fund_sources = current_user.fund_sources.with_currency(channel.currency)
      @assets = model_kls.where(member: current_user).order(:id).reverse_order.limit(10)
    end

    def deposit_params
      amount = params[:deposit][:amount]
      member_id = current_user.id
      account_id = params[:deposit][:account_id]
      currency = Currency.where(code: 'usd').first.id
      paypal_email = params[:deposit][:paypal_email]
      {account_id: account_id, member_id: member_id, currency: currency, amount: amount, paypal_email: paypal_email}
    end
  end
end
