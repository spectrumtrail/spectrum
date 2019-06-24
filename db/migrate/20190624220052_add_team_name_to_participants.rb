class AddTeamNameToParticipants < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :team_name, :string
  end
end
