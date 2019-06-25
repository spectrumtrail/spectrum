# This class is exclusively responsible for creating charges.
class CreateCharge
  attr_accessor :amount_in_cents, :customer, :registration, :token

  def initialize(amount_in_cents:, customer:, registration:, token:)
    @amount_in_cents = amount_in_cents
    @customer = customer
    @registration = registration
    @token = token
  end

  def perform
    Stripe::Charge.create(
      customer: customer.id,
      amount: amount_in_cents,
      description: description_for_charge,
      currency: "usd",
      metadata: meta_hash
    )
  end

  private

  def description_for_charge
    "#{registration.event.name} Registration Fee"
  end

  def meta_hash
    { event: registration.event.name, registration_id: registration.id }
  end
end
