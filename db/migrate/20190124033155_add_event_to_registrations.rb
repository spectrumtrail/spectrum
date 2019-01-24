class AddEventToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_reference :registrations, :event, foreign_key: true
  end
end
