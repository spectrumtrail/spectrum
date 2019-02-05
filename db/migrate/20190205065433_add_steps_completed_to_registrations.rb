class AddStepsCompletedToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :steps_seen, :text
    add_column :registrations, :steps_completed, :text
  end
end
