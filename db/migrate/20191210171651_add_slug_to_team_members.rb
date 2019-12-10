class AddSlugToTeamMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :team_members, :slug, :string
    add_index :team_members, :slug, unique: true
    TeamMember.find_each(&:save!) # builds the initial slug
  end
end
