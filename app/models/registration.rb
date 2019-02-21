class Registration < ApplicationRecord
  attr_accessor :discount_code_text

  serialize :steps_seen, Array
  serialize :steps_completed, Array

  has_secure_token

  belongs_to :event
  belongs_to :discount_code, counter_cache: true, optional: true
  has_one :location, through: :event
  has_one :participant, dependent: :destroy
  has_one :race, through: :participant
  accepts_nested_attributes_for :participant, allow_destroy: :true
  has_one :payment
  accepts_nested_attributes_for :payment

  validates :accepts_refund_terms, acceptance: true, if: :validate_payment?

  def amount_to_charge
    if discount_code.present? && discount_code.can_be_used_by?(email: billing_email)
      race.price_in_cents - discount_amount_in_cents
    else
      race.price_in_cents
    end
  end

  def discount_amount_in_cents
    if discount_code.cents.present?
      race.price_in_cents - discount_code.cents
    else
      race.price_in_cents * (discount_code.percent.to_f / 100)
    end
  end

  def default_billing_email
    billing_email ||= participant.email
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
