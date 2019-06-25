class CalculatesAmountToCharge
  attr_reader :discount_code, :registration, :race

  def initialize(registration:, discount_code: nil)
    @discount_code = discount_code
    @registration = registration
    @race = registration.race
  end

  def perform_with_expected_discount
    if discount_code_applicable?
      {
        discount_code_id: discount_code.id,
        message: "Applied discount code!",
        new_total_in_cents: discounted_total_in_cents,
        success: true
      }
    else
      {
        discount_code_id: nil,
        message: "This does not appear to be a valid discount code.",
        new_total_in_cents: race.price_in_cents,
        success: false
      }
    end
  end

  def amount_to_charge_in_integer_cents
    if discount_code_applicable?
      discounted_total_in_cents
    else
      race.price_in_cents
    end
  end

  def amount_to_charge_in_dollars_decimal
    amount_to_charge_in_integer_cents / 100.0
  end

  private

  def discounted_total_in_cents
    if total_discount_in_cents < race.price_in_cents
      (race.price_in_cents - total_discount_in_cents).to_i
    else
      0
    end
  end

  def discount_code_as_percent
    discount_code.percent.to_f / 100.0
  end

  def total_discount_in_cents
    discount_code.cents.to_i + percent_discount_in_cents
  end

  def percent_discount_in_cents
    race.price_in_cents * discount_code_as_percent
  end

  def usage_validator
    ValidatesDiscountCodeUsage.new(discount_code: discount_code)
  end

  def discount_code_applicable?
    usage_validator.code_can_be_used_by?(email: registration.default_billing_email)
  end
end
