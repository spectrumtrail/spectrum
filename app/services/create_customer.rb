# This service is responsible for creating a customer with a valid
# payment method on file within Stripe's Payment API.
# It does NOT charge credit cards by itself.
require 'stripe'

class CreateCustomer
  attr_accessor :email, :token

  def initialize(email:, token:)
    @email = email
    @token = token
  end

  def perform
    Stripe::Customer.create(email: email, source: token)
  end
end
