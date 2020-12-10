class VolunteerStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :volunteers, :active, :boolean
  end
end
