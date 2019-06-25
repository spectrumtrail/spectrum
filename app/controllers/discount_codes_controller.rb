class DiscountCodesController < ApplicationController
  def validate
    result = CalculatesAmountToCharge.new(
      registration: registration,
      discount_code: discount_code,
    ).perform_with_expected_discount

    respond_to do |format|
      format.json { render json: result }
    end
  end

  private

  def discount_code
    @code = DiscountCode.find_by_code(params[:id])
  end

  def registration
    @registration = Registration.find(params[:registration_id])
  end
end
