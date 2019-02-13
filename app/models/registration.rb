class Registration < ApplicationRecord
  serialize :steps_seen, Array
  serialize :steps_completed, Array

  has_secure_token

  belongs_to :event
  has_one :location, through: :event
  has_one :participant, dependent: :destroy
  accepts_nested_attributes_for :participant, allow_destroy: :true
  accepts_nested_attributes_for :payment

  validates :accepts_refund_terms, acceptance: true, if: :validate_payment?

  def amount_to_charge
    # TODO: This will need to become aware of any valid discount codes entered.
    participant.race.price_in_cents
  end

  def default_billing_email
    billing_email ||= participant.email
  end

  def complete?
    step_to_validate == "complete"
  end

  def paid?
    payment.present?
  end

  def to_param
    [id, token].join("-")
  end

  private

  def validate_payment?
    step_to_validate == "payment"
  end
end
