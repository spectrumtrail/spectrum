class AddRequiresTeamNameToRaces < ActiveRecord::Migration[5.2]
  def change
    add_column :races, :requires_team_name, :boolean, default: false
  end
end
