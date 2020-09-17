class RefundDecorator < ApplicationDecorator
  def stripe_charge_link_address
    "https://dashboard.stripe.com/payments/#{payment.stripe_charge_id}"
  end

  def amount_in_formatted_dollars
    h.number_to_currency(amount_in_dollars)
  end

  def amount_in_dollars
    amount_in_cents / 100 rescue 0
  end

  def participant_name
    registration.participant.full_name
  end

  def participant_email
    registration.participant.email
  end
end
