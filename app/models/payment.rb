class Payment < ApplicationRecord
  belongs_to :registration

  validates :amount_charged_in_cents, presence: true
  validates :registration, presence: true
  validates :stripe_charge_id, presence: true
  validates :stripe_customer_id, presence: true

  def amount_charged_in_dollars
    amount_charged_in_cents.to_f / 100
  end
end
