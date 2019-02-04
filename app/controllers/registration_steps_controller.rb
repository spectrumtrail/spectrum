class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  before_action :set_registration, :set_event

  steps :details, :waiver, :payment, :review, :confirmation

  def show
    render_wizard
  end

  def update

  end

  private

  def set_registration
    @registration = Registration.find_by_token(params[:token])
  end

  def set_event
    @event = @registration.event
  end
end
