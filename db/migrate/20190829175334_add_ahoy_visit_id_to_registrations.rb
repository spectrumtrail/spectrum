class AddAhoyVisitIdToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :ahoy_visit_id, :bigint
  end
end
