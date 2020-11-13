class CreateVolunteers < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteers do |t|
      t.references :event, foreign_key: true, index: true
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :position
      t.string :time

      t.timestamps
    end
  end
end
