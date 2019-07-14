class Admin::PaymentsController < Admin::BaseController
  before_action :set_payment, only: [:edit, :update, :destroy, :show]

  def index
    @payments = Payment.order(created_at: :desc)
    @payments = @payments.page(params[:page]).per(50).decorate
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_payment
    @payment = Payment.find(params[:id]).decorate
  end

  def payment_params
    params.require(:payment).permit!
  end
end
