class AddParticipantsCountToRaces < ActiveRecord::Migration[5.2]
  def change
    add_column :races, :participants_count, :integer, default: 0
    add_column :races, :participants_cap, :integer, default: 500
  end
end
