class PaymentDecorator < ApplicationDecorator
  def stripe_charge_link_address
    "https://dashboard.stripe.com/payments/#{stripe_charge_id}"
  end

  def stripe_customer_link_address
    "https://dashboard.stripe.com/customers/#{stripe_customer_id}"
  end

  def amount_in_formatted_dollars
    h.number_to_currency(amount_in_dollars)
  end

  def amount_in_dollars
    amount_charged_in_cents / 100 rescue 0
  end
end
