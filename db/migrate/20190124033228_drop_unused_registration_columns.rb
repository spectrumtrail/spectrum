class DropUnusedRegistrationColumns < ActiveRecord::Migration[5.2]
  def change
    # this columns are moving to PARTICIPANTS
    remove_column :registrations, :race_id, :bigint
    remove_column :registrations, :first_name, :string
    remove_column :registrations, :last_name, :string
    remove_column :registrations, :date_of_birth, :datetime
    remove_column :registrations, :division, :string
    remove_column :registrations, :mobile_phone, :string
    remove_column :registrations, :opted_in_for_communication
    remove_column :registrations, :emergency_contact_name
    remove_column :registrations, :emergency_contact_phone
    remove_column :registrations, :medical_conditions_description
    remove_column :registrations, :legal_guardian_name
    remove_column :registrations, :legal_guardian_phone_string
    remove_column :registrations, :legal_guardian_initials
    remove_column :registrations, :accepted_refund_policy
    remove_column :registrations, :accepted_waiver
    remove_column :races, :registrations_count, :integer
    remove_column :races, :registrations_limit, :integer

    # this column is being repurposed
    rename_column :registrations, :email, :billing_email
  end
end
