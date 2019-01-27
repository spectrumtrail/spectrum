class AddLastStepToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :last_step, :string
  end
end
