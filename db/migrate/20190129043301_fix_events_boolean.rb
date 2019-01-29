class FixEventsBoolean < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :is_active
    add_column :events, :is_active, :boolean, default: true
    add_column :series, :is_active, :boolean, default: true
  end
end
