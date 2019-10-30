class AddFieldsToTeamMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :team_members, :is_leader, :boolean, default: false
  end
end
