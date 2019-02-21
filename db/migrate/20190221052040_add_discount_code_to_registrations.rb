class AddDiscountCodeToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_reference :registrations, :discount_code, foreign_key: true
  end
end
