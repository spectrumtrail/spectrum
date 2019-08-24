class AddSocialLinksToTeamMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :team_members, :strava_link, :string
    add_column :team_members, :instagram_link, :string
  end
end
