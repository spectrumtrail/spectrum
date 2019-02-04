class AddStatusFieldsToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :status, :string
    add_column :registrations, :completed_at, :datetime
  end
end
