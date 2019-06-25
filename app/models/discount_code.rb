class DiscountCode < ApplicationRecord
  has_many :registrations
  validates :code, presence: true, length: { minimum: 4 }
  validates_uniqueness_of :code
  validates :cents, numericality: true, allow_nil: true
  validates :percent, numericality:  { greater_than: 5, less_than: 101 }, allow_nil: true

  def expired?
    expiration_date < Date.current
  end

  def exhausted?
    registrations_count >= limit
  end

  def allowed_for?(email:)
    if allowed_emails.any?
      allowed_emails.include? email
    else
      true
    end
  end

  def allowed_emails
    valid_emails.split(", ").uniq.sort
  end

  def used?
    registrations_count > 0
  end

  def used_by?(email:)
    registrations.pluck(:email).include? email
  end
end
