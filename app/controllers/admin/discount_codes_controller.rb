class Admin::DiscountCodesController < Admin::BaseController
  before_action :set_discount_code, only: [:edit, :update, :destroy, :show]

  def index
    @discount_codes = DiscountCode.order(registrations_count: :desc)
    @registrations = Registration.joins(:discount_code).
                                  group('discount_codes.code').
                                  order('count_id desc').
                                  count('id')
  end

  def show
  end

  def new
    @discount_code = DiscountCode.new
  end

  def edit
  end

  def create
    @discount_code = DiscountCode.new(discount_code_params)

    if @discount_code.save
      redirect_to(
        admin_discount_codes_path(@discount_code),
        notice: "Discount Code was successfully created."
      )
    else
      render :new
    end
  end

  def update
    if @discount_code.update(discount_code_params)
      redirect_to(
        admin_discount_codes_path(@discount_code),
        notice: "Discount Code was successfully updated."
      )
    else
      render :edit
    end
  end

  def destroy
    @discount_code.destroy
    redirect_to(
      admin_discount_codes_path,
      notice: "Discount Code was successfully destroyed."
    )
  end

  private

  def set_discount_code
    @discount_code = DiscountCode.find_by_id params[:id]
  end

  def discount_code_params
    params.require(:discount_code).permit!
  end
end
