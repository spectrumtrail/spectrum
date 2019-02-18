class DiscountCodesController < ApplicationController
  before_action :fetch_code

  def validate
    # if @code.present?
    #   result = ValidateDiscountCodeForRegistration.new(@code, @registration).perform
    #   result = {
    #     valid: result.success?,
    #     message:
    #     discount_amount: @code.discounted_price
    #   }
    # else
    #   result = {
    #     valid: false,
    #     new_total: @registration.
    #   }
    # end

    result = {
      valid: true
    }

    respond_to do |format|
      format.json { render json: result }
    end
  end

  private

  def fetch_code
    @code = DiscountCode.find_by_code(params[:id])
  end

  def find_race
    @registration = Registration.find(params[:registration_id])
  end
end
