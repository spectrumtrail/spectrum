require 'csv'

class ImportExistingRegistration
  attr_accessor :file_import, :file_to_import

  def initialize(file_import:)
    @file_import = file_import
    @file_to_import = file_import.csv_file_to_import
  end

  def perform
    Registration.transaction do
      lines = CSV.parse(file_to_import.download, headers: true)
      lines.each do |line|
        process_line(
          OpenStruct.new(line.to_hash)
        )
      end
    end
  end

  private

  def process_line(line)
    puts line.inspect
    event = Event.where('name ILIKE ?', "%#{line.event_name}%").first!
    race = event.races.not_archived.where('name ILIKE ?', "%#{line.race_name}%").first
    discount_code = DiscountCode.find_by_code line.discount_code_used

    registration = Registration.create!(
      event_id: event.id,
      accepts_refund_terms: true,
      billing_email: line.email,
      step_to_validate: 'confirmation',
      started_at: Time.current,
      steps_seen: all_steps,
      steps_completed: all_steps,
      admin_notes: "Created by Bulk Import.",
      completed_at: Time.current,
      discount_code_id: discount_code.try(:id)
    )

    participant = Participant.create!(
      event_id: event.id,
      accepts_waiver: true,
      registration_id: registration.id,
      race_id: race.id,
      first_name: line.first,
      last_name: line.last,
      email: line.email,
      division: line.division,
      city: line.city,
      address: line.address,
      state: line.state,
      zip: line.zip,
      phone: line.phone,
      medical_conditions: line.medical_text,
      birth_date: Date.strptime(line.dob, "%m/%d/%Y"),
      emergency_contact_name: line.emergency_name,
      emergency_contact_phone: line.emergency_phone,
    )

    payment = Payment.create!(
      registration: registration,
      stripe_charge_id: line.stripe_charge_id,
      amount_charged_in_cents: line.amount_in_dollars.to_i * 100
    )

    puts 'Success!'
  end

  def all_steps
    ['details', 'waiver', 'payment', 'confirmation']
  end
end
