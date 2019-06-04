class Participant < ApplicationRecord
  belongs_to :registration
  belongs_to :event
  belongs_to :race
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
  validates :zip, presence: true, if: :validate_details?

  validates :emergency_contact_name, presence: true, if: :validate_waiver?
  validates :emergency_contact_phone, presence: true, if: :validate_waiver?
  validates :accepts_waiver, acceptance: true, if: :validate_waiver?

  delegate :step_to_validate, to: :registration

  scope :with_payment, -> { joins(:payment) }

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
