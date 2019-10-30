class AddTitleToTeamMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :team_members, :title, :string
  end
end
