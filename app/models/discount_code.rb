class DiscountCode < ApplicationRecord
  has_many :registrations
  validates :code, presence: true, length: { minimum: 4 }
  validates :cents, numericality: true, allow_nil: true
  validates :percent, numericality:  { greater_than: 5, less_than: 101 }, allow_nil: true

  def can_be_used_by?(email:)
    return false if expiration_date < Date.current
    return false if registrations_count >= limit
    if valid_emails.present?
      valid_emails.split(",").include? email
    else
      true
    end
  end

  def used?
    registrations_count > 0
  end

  def used_by?(email:)
    registrations.pluck(:email).include? email
  end
end
