class AddPaypalEmailToWithdraw < ActiveRecord::Migration
  def change
    add_column :withdraws, :paypal_email, :string
  end
end
