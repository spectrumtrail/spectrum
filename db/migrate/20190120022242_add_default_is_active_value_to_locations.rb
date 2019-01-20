class AddDefaultIsActiveValueToLocations < ActiveRecord::Migration[5.2]
  def change
    change_column :locations, :is_active, :boolean, default: true
  end
end
