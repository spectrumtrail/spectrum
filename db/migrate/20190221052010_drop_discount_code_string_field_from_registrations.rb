class DropDiscountCodeStringFieldFromRegistrations < ActiveRecord::Migration[5.2]
  def change
    remove_column :registrations, :discount_code, :string
  end
end
