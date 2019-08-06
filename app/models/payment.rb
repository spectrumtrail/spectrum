class Payment < ApplicationRecord
  belongs_to :registration

  validates :amount_charged_in_cents, presence: true
  validates :registration, presence: true
  has_many :refunds

  def amount_charged_in_dollars
    amount_charged_in_cents.to_f / 100
  end

  def amount_refundable_in_cents
    amount_charged_in_cents - refunds.sum(&:amount_in_cents)
  end

  def refunded?
    refunds.any?
  end
end
