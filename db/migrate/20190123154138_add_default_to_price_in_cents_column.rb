class AddDefaultToPriceInCentsColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :races, :price_in_cents, :integer, default: 100
  end
end
