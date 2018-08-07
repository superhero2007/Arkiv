class AddPaypalEmailToDeposit < ActiveRecord::Migration
  def change
    add_column :deposits, :paypal_email, :string
  end
end
