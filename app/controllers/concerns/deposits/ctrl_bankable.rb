module Deposits
  module CtrlBankable
    extend ActiveSupport::Concern

    included do
      before_filter :fetch
    end

    def create
      @deposit = model_kls.new(deposit_params)

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
      fund_source_id = params[:fund_source]
      fund_source = FundSource.find(fund_source_id)
      fund_uid = fund_source.uid 
      fund_extra = fund_source.extra
      fund_routing_number = fund_source.routing_number
      currency = Currency.where(code: 'usd').first
      {account_id: account_id,fund_routing_number: fund_routing_number, member_id: member_id, amount: amount, fund_uid: fund_uid, fund_extra: fund_extra, currency: currency.id, fund_source: fund_source.id}
    end
  end
end
