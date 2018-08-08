module Admin
  module Withdraws
    class BaseController < ::Admin::BaseController
      before_action :find_withdraw, only: [:show, :update, :destroy]

      def channel
        @channel ||= WithdrawChannel.find_by_key(self.controller_name.singularize)
      end

      def kls
        channel.kls
      end

      def find_withdraw

      end
    end
  end
end
