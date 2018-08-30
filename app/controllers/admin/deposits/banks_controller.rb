module Admin
  module Deposits
    class BanksController < ::Admin::Deposits::BaseController
      #load_and_authorize_resource :class => '::Deposits::Bank'

      def index
        @deposits = Deposit.all.with_aasm_state(:submitting).order('created_at DESC')
      end

      def show
        @deposit = Deposit.find(params[:id])
      end

      def update
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        @bank.charge!(target_params[:txid])

        redirect_to :back
      end

      def accept
        deposit = Deposit.find(params[:id])
        deposit.aasm_state = "accepted"
        deposit.account.lock!.plus_funds deposit.amount, reason: Account::DEPOSIT, ref: deposit 
        deposit.save
        redirect_to admin_deposits_bank_path(params[:id])
      end

      def reject
        deposit = Deposit.find(params[:id])
        deposit.aasm_state = "rejected"
        deposit.save
        redirect_to admin_deposits_bank_path(params[:id])
      end

      private
      def target_params
        params.require(:deposits_bank).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end

