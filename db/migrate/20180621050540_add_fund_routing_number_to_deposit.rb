class AddFundRoutingNumberToDeposit < ActiveRecord::Migration
  def change
    add_column :deposits, :fund_routing_number, :string
  end
end
