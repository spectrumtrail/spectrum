class RegistrationDecorator < ApplicationDecorator
  def event_name
    event.name
  end

  def event_race_name
    event.name + " - " + race.name
  end

  def event_race_name_link
    h.link_to event_race_name, h.admin_event_path(event)
  end

  def participant_name
    participant.full_name
  end

  def payment_details_link
    if payment.present?
      h.link_to h.number_to_currency(payment.amount_charged_in_dollars), "#coming soon"
    else
      "No Payment"
    end
  end

  def race_name
    participant.race.name
  end

  def discount_code_used
    if discount_code.present?
      discount_code.code
    else
      none
    end
  end
end
