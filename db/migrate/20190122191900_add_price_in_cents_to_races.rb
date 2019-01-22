class AddPriceInCentsToRaces < ActiveRecord::Migration[5.2]
  def change
    add_column :races, :price_in_cents, :integer
  end
end
