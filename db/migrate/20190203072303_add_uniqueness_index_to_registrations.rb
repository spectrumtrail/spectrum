class AddUniquenessIndexToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_index :registrations, :token, unique: true
  end
end
