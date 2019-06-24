class AddAllowsTeamsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :allows_teams, :boolean, default: false
  end
end
