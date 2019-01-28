class AddEmergencyContactInfoToParticipants < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :emergency_contact_name, :string
    add_column :participants, :emergency_contact_phone, :string
  end
end
