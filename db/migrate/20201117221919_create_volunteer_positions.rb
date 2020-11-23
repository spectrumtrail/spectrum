class CreateVolunteerPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteer_positions do |t|
      t.references :event, foreign_key: true, index: true
      t.string :name
    end

    change_table :volunteers do |t|
      t.references :volunteer_position, foreign_key: true, index: true
    end
  end
end
