# This service is responsible for creating a Payment.
# This will create a Charge if the payment is valid.

require 'stripe'

class CreatePayment
  attr_accessor :charge_calculator, :customer, :registration, :token

  def initialize(registration:, token:)
    @registration = registration
    @token = token
    @charge_calculator = CalculatesAmountToCharge.new(
      registration: registration,
      discount_code: registration.discount_code
    )
  end

  def perform
    if registration.invalid?
      handle_invalid_registration
    elsif registration.paid?
      handle_paid_registration
    else
      create_payment
    end
  end

  private

  def handle_invalid_registration
    messages = registration.errors.full_messages << "Your card has not been charged!"
    ServiceResponse.new(
      message: messages.join(". "),
      object: registration,
      success: false
    )
  end

  def handle_paid_registration
    ServiceResponse.new(
      message: "This registration has already been paid!",
      object: registration,
      success: false
    )
  end

  def catch_exception(exception)
    ServiceResponse.new(
      message: exception.message + " Please try again.",
      object: exception,
      success: false
    )
  end

  def create_charge
    CreateCharge.new(
      amount_in_cents: charge_calculator.amount_to_charge_in_integer_cents,
      customer: customer,
      registration: registration,
      token: token
    ).perform
  end

  def create_customer
    CreateCustomer.new(email: registration.billing_email, token: token).perform
  end

  def create_payment
    if charge_calculator.amount_to_charge_in_integer_cents > 0
      create_payment_with_charge
    else
      create_payment_without_charge
    end
  end

  def create_payment_without_charge
    payment = Payment.create!(
      registration: registration,
      amount_charged_in_cents: 0
    )

    ServiceResponse.new(
      message: "Successfully processed your free race registration! Your card was not charged.",
      object: payment,
      success: true
    )
  end

  def create_payment_with_charge
    customer = create_customer
    charge = create_charge

    payment = Payment.create!(
      registration: registration,
      stripe_charge_id: charge.try(:id),
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
