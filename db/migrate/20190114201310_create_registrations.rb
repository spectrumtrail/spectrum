class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.references :race, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.datetime :date_of_birth
      t.string :email
      t.string :division
      t.string :mobile_phone
      t.boolean :opted_in_for_communication
      t.string :emergency_contact_name
      t.string :emergency_contact_phone
      t.text :medical_conditions_description
      t.string :legal_guardian_name
      t.string :legal_guardian_phone_string
      t.string :legal_guardian_initials
      t.boolean :accepted_refund_policy
      t.boolean :accepted_waiver

      t.timestamps
    end
  end
end
