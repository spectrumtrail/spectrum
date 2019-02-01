class AddStartedAtToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :started_at, :datetime
  end
end
