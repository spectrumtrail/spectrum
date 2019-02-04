class AddKeepPrivateToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :keep_private, :boolean, default: false
  end
end
