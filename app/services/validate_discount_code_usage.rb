class ValidateDiscountCodeUsage
  attr_reader :code, :registration, :race
  def initialize(code:, registration:)
    @code = code
    @registration = registration
    set_race
  end

  def perform
    if code.can_be_used_by?(email: registration.billing_email)
      {
        discount_code_id: code.id,
        message: "Applied discount code!",
        new_total_in_cents: new_total_in_cents,
        object: code,
        success: true
      }
    else
      {
        message: "This does not appear to be a valid discount code.",
        new_total_in_cents: registration.amount_to_charge.to_i,
        object: code,
        success: false
      }
    end
  end

  private

  def discount_amount_in_cents
    if code.cents.present?
      race.price_in_cents - code.cents
    else
      race.price_in_cents * (code.percent.to_f / 100)
    end
  end

  def new_total_in_cents
    race.price_in_cents - discount_amount_in_cents
  end

  def set_race
    @race = Participant.where(registration_id: registration).first.race
  end
end
