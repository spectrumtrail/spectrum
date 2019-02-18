class DiscountCode < ApplicationRecord
  validates :code, presence: true, length: { minimum: 4 }
  validates :cents, numericality: true
  validates :percent, numericality:  { greater_than: 5, less_than: 101 }

  def is_valid?
    return false if expiration_date < Date.current
    return false if times_used >= limit
  end


end
