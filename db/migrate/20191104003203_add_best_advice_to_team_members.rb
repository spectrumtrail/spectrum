class AddBestAdviceToTeamMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :team_members, :best_advice, :string
  end
end
