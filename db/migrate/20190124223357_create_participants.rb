class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.references :registration, foreign_key: true
      t.references :race, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :division
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :medical_conditions
      t.datetime :birth_date

      t.timestamps
    end
  end
end
