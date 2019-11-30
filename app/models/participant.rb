require 'csv'

class Participant < ApplicationRecord
  belongs_to :registration
  belongs_to :event
  belongs_to :race, counter_cache: true
  has_one :payment, through: :registration

  validates :race, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
    presence: true,
    format: {
      with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
      message: "This email address looks unusual and may break our system. Please use a different one."
    }

  validates :phone, presence: true, if: :validate_details?
  validates :division, presence: true, if: :validate_details?
  validates :birth_date, presence: true, if: :validate_details?
  validates :address, presence: true, if: :validate_details?
  validates :city, presence: true, if: :validate_details?
  validates :state, presence: true, if: :validate_details?

  validates :emergency_contact_name, presence: true, if: :validate_waiver?
  validates :emergency_contact_phone, presence: true, if: :validate_waiver?
  validates :accepts_waiver, acceptance: true, if: :validate_waiver?

  delegate :step_to_validate, to: :registration

  scope :with_payment, -> { joins(:payment) }
  scope :created_after, ->(time) { after(time) }
  scope :not_cancelled, -> { joins(:registration).where(registrations: { cancelled_at: nil }) }
  scope :for_start_list, -> { with_payment.not_cancelled }

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  private

  def validate_details?
    ["completed", "details"].include? registration.step_to_validate
  end

  def validate_waiver?
    ["completed", "waiver"].include? registration.step_to_validate
  end

  def self.to_event_start_list_csv(event_id:)
    CSV.generate(headers: true) do |csv|
      csv << ['First Name', 'Last Name', 'Age', 'Gender', 'Race', 'Location']

      scope = includes(:race).
              where(event_id: event_id).
              for_start_list.
              reorder('races.name ASC')

      scope.decorate.each do |participant|
        csv << [
          participant.first_name.titleize,
          participant.last_name.titleize,
          participant.race_day_age,
          participant.division,
          participant.race_name,
          participant.city_and_state
        ]
      end
    end
  end
end
