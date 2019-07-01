class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  before_action(
    :set_registration,
    :check_registration_window,
    :check_participant_count,
    :set_stripe_key
  )

  steps :details, :waiver, :payment, :confirmation

  def show
    update_steps_seen
    render_wizard
  end

  def update
    if step == :payment
      @registration.assign_attributes(registration_params)
      handle_payment_result_for(
        process_payment(token: params[:stripe_token])
      )
    else
      @registration.assign_attributes(registration_params)
      update_steps_completed if @registration.valid?
      render_wizard @registration
    end
  end

  private

  def check_token
    if @registration.token != registration_token
      redirect_to danger_path
    end
  end

  def check_registration_window
    unless @event.registration_open?(Time.current) # giving an hour to finish once started
      redirect_to(
        event_path(@event),
        alert: "The time window to register for this event has closed before you could finish your registration. Please try again next year! If you're seeing this message, rest assured your credit card has NOT been charged."
      ) and return
    end
  end

  def check_participant_count
    unless @registration.race.is_registerable?(Time.current)
      redirect_to(
        event_path(@event),
        alert: "This race is no longer available for registration. It has either been cancelled; or, has filled up. Please pick a different race, or, try again next year! If you're seeing this message, rest assured your credit card has NOT been charged."
      ) and return
    end
  end

  def handle_payment_result_for(result)
    if result.success?
      update_steps_completed
      @registration.update(completed_at: Time.now)
      RaceRegistrationMailer.with(registration: @registration).confirm.deliver_now
      render_wizard @registration
    else
      @card_errors = result.message
      flash.now[result.flash_status] = result.flash_message
      render_wizard
    end
  end

  def process_payment(token:)
    CreatePayment.new(registration: @registration, token: token).perform
  end

  def registration_params
    params.require(:registration).permit!
  end

  def registration_token
    params[:registration_id].split("-").last
  end

  def set_stripe_key
    credentials = Rails.application.credentials.send(Rails.env)
    gon.stripe_publishable_key = credentials.fetch(:stripe_publishable_key)
  end

  def set_registration
    @event = Event.friendly.find(params[:event_id])
    @registration = Registration.find(params[:registration_id])
    check_token
    @registration.step_to_validate = step
  end

  def update_steps_seen
    steps_seen = @registration.steps_seen | [step.to_s]
    @registration.update(steps_seen: steps_seen)
  end

  def update_steps_completed
    steps_completed = @registration.steps_completed | [step.to_s]
    @registration.update(steps_completed: steps_completed)
  end
end
