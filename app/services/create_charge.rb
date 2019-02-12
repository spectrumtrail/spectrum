# This class is exclusively responsible for creating charges.
class CreateCharge
  attr_accessor :customer, :registration, :token

  def initialize(customer:, registration:, token:)
    @customer = customer
    @registration = registration
    @token = token
  end

  def perform
    Stripe::Charge.create(
      customer: customer.id,
      amount: registration.amount_to_charge,
      description: "#{registration.event.name} Registration Fee",
      currency: "usd",
      metadata: meta_hash
    )
  end

  private

  def meta_hash
    { event: registration.event.name, registration_id: registration.id }
  end
end
