module Private
  class HistoryController < BaseController
    layout 'application'

    def transactions
      @market = current_market
      @deposits = Deposit.where(member: current_user).with_aasm_state(:accepted)
      @withdraws = Withdraw.where(member: current_user).with_aasm_state(:done)
      @buys = Trade.where(bid_member_id: current_user.id)
      @sells = Trade.where(ask_member_id: current_user.id)

      gon.jbuilder controller: self
    end

    def orders
      @orders = current_user.orders.includes(:trades).order("id desc").page(params[:page]).per(50)
    end

  end
end
