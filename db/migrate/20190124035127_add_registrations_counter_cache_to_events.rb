class AddRegistrationsCounterCacheToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :registrations_count, :integer, default: 0
  end
end
