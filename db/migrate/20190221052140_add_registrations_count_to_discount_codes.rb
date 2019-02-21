class AddRegistrationsCountToDiscountCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :discount_codes, :registrations_count, :integer, default: 0
  end
end
