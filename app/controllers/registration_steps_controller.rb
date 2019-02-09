class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  before_action :set_registration, :set_event, :set_keys

  # Important! These steps are not 1:1 reflected in the UI. Semantics matter.
  steps :details, :waiver, :payment, :confirmation

  def show
    update_steps_seen
    render_wizard
  end

  def update
    @registration.assign_attributes(registration_params)
    update_steps_completed if @registration.valid?
    render_wizard @registration
  end

  private

  def registration_params
    params.require(:registration).permit!
  end

  def payment_params
    params.require(:payment).permit!
  end

  def set_event
    @event = Event.friendly.find(params[:event_id])
  end

  def set_keys
    gon.foo = "bar"
    if Rails.env.development?
      credentials = Rails.application.credentials.development
      gon.stripe_publishable_key = credentials[:STRIPE_PUBLISHABLE_KEY]
    else
      ENV['STRIPE_PUBLISHABLE_KEY']
    end
  end

  def set_registration
    @registration = Registration.find(params[:registration_id])
    @registration.step_to_validate = step
  end

  def set_step_to_validate
    if step == steps.last
      "complete"
    else
      step.to_s
    end
  end

  def update_steps_seen
    @registration.update(steps_seen: @registration.steps_seen | [step.to_s])
  end

  def update_steps_completed
    @registration.update(steps_completed: @registration.steps_completed | [step.to_s])
  end
end
