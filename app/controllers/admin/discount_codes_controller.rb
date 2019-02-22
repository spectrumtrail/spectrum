class Admin::DiscountCodesController < Admin::BaseController
  before_action :set_registration, only: [:edit, :update, :destroy, :show]

  def index
    @discount_codes = DiscountCode.order(:code)
  end

  def show
  end

  def new
    @discount_code = DiscountCode.new
  end

  def edit
  end

  def create
    @discount_code = DiscountCode.new(registration_params)

    if @discount_code.save
      redirect_to(
        admin_registration_path(@discount_code),
        notice: "DiscountCode was successfully created."
      )
    else
      render :new
    end
  end

  def update
    if @discount_code.update(registration_params)
      redirect_to(
        admin_registration_path(@discount_code),
        notice: "DiscountCode was successfully updated."
      )
    else
      render :edit
    end
  end

  def destroy
    @discount_code.destroy
    redirect_to(
      admin_registrations_path,
      notice: "DiscountCode was successfully destroyed."
    )
  end

  private

  def set_registration
    @discount_code = DiscountCode.find_by_id params[:id]
  end

  def registration_params
    params.require(:registration).permit!
  end
end
