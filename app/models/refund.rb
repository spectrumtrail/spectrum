class Refund < ApplicationRecord
  belongs_to :payment, counter_cache: true
  validates :admin_reason, presence: true
  validates :stripe_refund_id, presence: true
end
