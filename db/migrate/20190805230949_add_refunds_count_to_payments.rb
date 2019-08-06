class AddRefundsCountToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :refunds_count, :integer, default: 0
  end
end
