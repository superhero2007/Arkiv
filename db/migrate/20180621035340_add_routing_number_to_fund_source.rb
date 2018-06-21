class AddRoutingNumberToFundSource < ActiveRecord::Migration
  def change
    add_column :fund_sources, :routing_number, :string
  end
end
