class AddFeeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :order_fee, :decimal, precision: 32, scale: 16
  end
end
