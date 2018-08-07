module Withdraws
  module Withdrawable
    extend ActiveSupport::Concern

    included do
      before_filter :fetch
    end

    def create
      @withdraw = Withdraw.new(withdraw_params)

      #if two_factor_auth_verified?
        if @withdraw.save
          @withdraw.submit!
          render nothing: true
        else
          render text: @withdraw.errors.full_messages.join(', '), status: 403
        end
      #else
      #  render text: I18n.t('private.withdraws.create.two_factors_error'), status: 403
      #end
    end

    def destroy
      Withdraw.transaction do
        @withdraw = current_user.withdraws.find(params[:id]).lock!
        @withdraw.cancel
        @withdraw.save!
      end
      render nothing: true
    end

    private

    def fetch
      @account = current_user.get_account(channel.currency)
      @model = model_kls
      @fund_sources = current_user.fund_sources.with_currency(channel.currency)
      @assets = model_kls.without_aasm_state(:submitting).where(member: current_user).order(:id).reverse_order.limit(10)
    end

    def withdraw_params
      sum = params[:withdraw][:sum]
      account_id = params[:withdraw][:account_id]
      currency = Currency.where(code: 'usd').first.id 
      paypal_email = params[:withdraw][:paypal_email]

      {sum: sum, member_id: current_user.id, account_id: account_id, currency: currency, paypal_email: paypal_email}
    end

  end
end
