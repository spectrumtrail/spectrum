class AddDiscountCodeTextToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :discount_code, :string
  end
end
