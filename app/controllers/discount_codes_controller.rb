class DiscountCodesController < ApplicationController
  before_action :fetch_code

  def validate
    if @code.present?
      result = ValidateDiscountCodeUsage.new(
        code: @code,
        registration: fetch_registration
      ).perform
    else
      result = {
        success: false,
        message: "No code was given."
      }
    end

    respond_to do |format|
      format.json { render json: result }
    end
  end

  private

  def fetch_code
    @code = DiscountCode.find_by_code(params[:id])
  end

  def fetch_registration
    @registration = Registration.find(params[:registration_id])
  end
end
