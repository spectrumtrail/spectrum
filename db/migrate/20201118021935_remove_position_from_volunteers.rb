class RemovePositionFromVolunteers < ActiveRecord::Migration[5.2]
  def change
    remove_column :volunteers, :position
  end
end
