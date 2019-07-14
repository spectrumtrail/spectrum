class Payment < ApplicationRecord
  belongs_to :registration

  validates :amount_charged_in_cents, presence: true
  validates :registration, presence: true

  def amount_charged_in_dollars
    amount_charged_in_cents.to_f / 100
  end

  def refunded?
    false
  end
end
