module Admin
  module Withdraws
    class BanksController < ::Admin::Withdraws::BaseController
      #load_and_authorize_resource :class => '::Withdraws::Bank'

      def index
        @withdraws = Withdraw.all.with_aasm_state(:submitting)
      end

      def show
        @withdraw = Withdraw.find(params[:id])
      end

      def accept
        withdraw = Withdraw.find(params[:id])
        withdraw.aasm_state = "accepted"
        withdraw.account.lock!.plus_funds withdraw.amount, reason: Account::withdraw, ref: withdraw 
        withdraw.save
        redirect_to admin_withdraws_bank_path(params[:id])
      end

      def reject
        withdraw = Withdraw.find(params[:id])
        withdraw.aasm_state = "rejected"
        withdraw.save
        redirect_to admin_withdraws_bank_path(params[:id])
      end

      def update
        if @bank.may_process?
          @bank.process!
        elsif @bank.may_succeed?
          @bank.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @bank.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
