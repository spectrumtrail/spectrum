class AddLimitToDiscountCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :discount_codes, :limit, :integer
    add_column :discount_codes, :times_used, :integer, default: 0
    add_column :discount_codes, :is_active, :boolean, default: true
    remove_column :discount_codes, :check_email, :boolean
  end
end
