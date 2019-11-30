class RegistrationDecorator < ApplicationDecorator
  def event_name
    event.name
  end

  def event_race_name
    event.name + " - " + race.name.truncate(10)
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

  def status_icon
    if registration.cancelled?
      h.content_tag(:i, '', class: 'fa fa-ban text-danger')
    elsif registration.complete?
      h.content_tag(:i, '', class: 'fas fa-check-circle text-success')
    else
      h.content_tag(:i, '', class: 'fas fa-circle-notch text-warning')
    end
  end

  def status_text
    if registration.cancelled?
      h.local_time registration.cancelled_at
    elsif registration.complete?
      h.local_time registration.completed_at
    else
      h.local_time_ago registration.updated_at
    end
  end

  def status
    status_icon + ' ' + status_text
  end
end
