module Admin
    class ReportsController < BaseController
        
        def daily_fees
            buy_orders = OrderAsk.done
            sell_orders = OrderBid.done
            deposits = Deposit.with_aasm_state :accepted
            withdrawals = Withdraw.where(aasm_state: [:accepted, :done])
            @data = []
            buy_orders.each do |x|
                tmp = {'date' => x.done_at, 'reason' => 'Buy', 'user' => Member.find_by_id(x.member_id).email, 'ticker' => x.ask.upcase, 'shares' => x.volume, 'price' => x.price, 'total' => x.price * x.volume, 'fees' => x.order_fee}
                @data.push(tmp)
            end
            sell_orders.each do |x|
                tmp = {'date' => x.done_at, 'reason' => 'Sell', 'user' => Member.find_by_id(x.member_id).email, 'ticker' => x.bid.upcase, 'shares' => x.volume, 'price' => x.price, 'total' => x.price * x.volume, 'fees' => x.order_fee}
                @data.push(tmp)
            end
            deposits.each do |x|
                tmp = {'date' => x.updated_at, 'reason' => 'Deposit', 'user' => Member.find_by_id(x.member_id).email, 'ticker' => "", 'shares' => "", 'price' => "", 'total' => x.amount, 'fees' => x.fee}
                @data.push(tmp)
            end
            withdrawals.each do |x|
                tmp = {'date' => x.updated_at, 'reason' => 'Withdraw', 'user' => Member.find_by_id(x.member_id).email, 'ticker' => "", 'shares' => "", 'price' => "", 'total' => x.amount, 'fees' => x.fee}
                @data.push(tmp)
            end
            sort_param = params[:sort] || 'date'
            @data = @data.sort_by{|a, b| a[sort_param] <=> b[sort_param]}.reverse
        end

    end
end