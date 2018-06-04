module Private
  class FundsController < BaseController
    layout 'funds'

    before_action :auth_activated!
    before_action :auth_verified!
    before_action :two_factor_activated!

    def index
      @deposit_channels = DepositChannel.where(currency: 'usd')
      @withdraw_channels = WithdrawChannel.where(currency: 'usd')
      @currencies = Currency.where(code: 'usd')
      @deposits = current_user.deposits
      @accounts = current_user.accounts.where(currency: @currencies.first.id)
      @withdraws = current_user.withdraws
      @fund_sources = current_user.fund_sources
      @banks = Bank.all

      gon.jbuilder
    end

    def balances
      @accounts =  current_user.accounts.page(params[:page]).per(12)
      @fund_sources = current_user.fund_sources
    end

    def deposit_usd
      fund_source = FundSource.find(params[:fund_source])
      currency = Currency.where(code: 'usd')
      account = current_user.accounts.where(currency: currency.first.id)
      deposit = Deposit.new(account: account.first, amount: params[:amount], member: current_user, currency: currency.first.id, fee: 0.001, fund_uid: fund_source.uid, fund_extra: fund_source.extra)
      if deposit.save
        deposit.submit! 
      end
      redirect_to balances_path
    end

    def withdraw_usd
      redirect_to balances_path, notice: 'Withdraw Submited'
    end

    def gen_address
      current_user.accounts.each do |account|
        next if not account.currency_obj.coin?

        if account.payment_addresses.blank?
          account.payment_addresses.create(currency: account.currency)
        else
          address = account.payment_addresses.last
          address.gen_address if address.address.blank?
        end
      end
      render nothing: true
    end

  end
end

