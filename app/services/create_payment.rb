# This service is responsible for creating a Payment.
# This will create a Charge if the payment is valid.

require 'stripe'

class CreatePayment
  attr_accessor :registration, :token

  def initialize(registration:, token:)
    @registration = registration
    @token = token
  end

  def perform
    if registration.invalid?
      messages = registration.errors.full_messages << "Your card has not been charged!"
      ServiceResponse.new(
        message: messages.join(". "),
        object: registration,
        success: false
      )
    elsif registration.paid?
      ServiceResponse.new(
        message: "This registration has already been paid!",
        object: registration,
        success: false
      )
    else
      create_payment
    end
  end

  private

  def catch_exception(exception)
    ServiceResponse.new(
      message: exception.message + " Please try again.",
      object: exception,
      success: false
    )
  end

  def create_charge_for(customer)
    CreateCharge.new(customer: customer, registration: registration, token: token).perform
  end

  def create_customer
    CreateCustomer.new(email: registration.billing_email, token: token).perform
  end

  def create_payment
    customer = create_customer
    charge = create_charge_for(customer)

    payment = Payment.create!(
      registration: registration,
      stripe_charge_id: charge.id,
      stripe_customer_id: customer.id,
      amount_charged_in_cents: charge.amount
    )

    ServiceResponse.new(
      message: "Sucessfully charged card.",
      object: payment,
      success: true
    )
  rescue Stripe::CardError, Stripe::InvalidRequestError, Stripe::StripeError => error
    catch_exception(error)
  end
end
