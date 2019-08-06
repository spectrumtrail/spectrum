# This service is responsible for creating a Payment.
# This will create a Charge if the payment is valid.
require 'stripe'
class RefundPaymentRequest
  attr_accessor :refund, :payment

  def initialize(refund:, payment:)
    @refund = refund
    @payment = payment
  end

  def perform
    stripe_refund = request_refund
    refund.stripe_refund_id = stripe_refund.id
    refund.save!

    ServiceResponse.new(
      message: "Refund successfully requested! Check its details page for status updates.",
      object: refund,
      success: true
    )
  rescue Stripe::InvalidRequestError => error
    ServiceResponse.new(
      message: error.message,
      object: refund,
      success: false
    )
  end

  private

  def request_refund
    Stripe::Refund.create(
      amount: refund.amount_in_cents,
      charge: payment.stripe_charge_id,
      metadata: meta_hash,
      reason: refund.admin_reason,
    )
  end

  def meta_hash
    {
      admin_notes: refund.admin_notes
    }
  end
end
