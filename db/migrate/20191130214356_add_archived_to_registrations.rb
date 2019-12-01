class AddArchivedToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :archived_at, :datetime
  end
end
