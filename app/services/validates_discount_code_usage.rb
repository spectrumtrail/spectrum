class ValidatesDiscountCodeUsage
  attr_reader :discount_code

  def initialize(discount_code:)
    @discount_code = discount_code
  end

  def code_can_be_used_by?(email:)
    return false unless discount_code.present?
    return false unless discount_code.is_active?
    return false if discount_code.expired?
    return false if discount_code.exhausted?
    return false unless discount_code.allowed_for?(email: email)
    return true
  end
end
