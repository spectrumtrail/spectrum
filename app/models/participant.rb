class Participant < ApplicationRecord
  belongs_to :registration
  belongs_to :event
  belongs_to :race

  validates :race, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
    presence: true,
    format: {
      with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
      message: "looks unusual. Please use a different one."
    },
    uniqueness: {
      scope: [:race_id, :event_id],
      message: "is already associated with a participant for this race. Have you already registered? If so, check your email for your confirmation. If you are trying to register someone else, please be sure to use their email address, and make sure they are with you so that they can accept the waiver terms on their own (legal stuff). This is important so that we know who is racing and how to get ahold of them."
    }

  validates :phone, presence: true, if: :validate_details?
  validates :division, presence: true, if: :validate_details?
  validates :birth_date, presence: true, if: :validate_details?
  validates :address, presence: true, if: :validate_details?
  validates :city, presence: true, if: :validate_details?
  validates :state, presence: true, if: :validate_details?
  validates :zip, presence: true, if: :validate_details?

  validates :emergency_contact_name, presence: true, if: :validate_waiver?
  validates :emergency_contact_phone, presence: true, if: :validate_waiver?
  validates :accepts_waiver, acceptance: true, if: :validate_waiver?

  delegate :step_to_validate, to: :registration

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
end
