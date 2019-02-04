class AddDefaultValueToEventTimeZones < ActiveRecord::Migration[5.2]
  def change
    change_column_default :events, :time_zone, "Central Time (US & Canada)"
  end
end
