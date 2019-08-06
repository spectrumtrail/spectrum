class Admin::RefundsController < Admin::BaseController
  before_action :set_refund, only: [:edit, :update, :destroy, :show]

  def index
    @refunds = Refund.order(created_at: :desc)
    @refunds = @refunds.page(params[:page]).per(50).decorate
  end

  def new
    @refund = Refund.new(payment_id: params[:payment_id])
    @payment = Payment.find params[:payment_id]
  end

  def create
    response = request_refund

    if response.success
      redirect_to(
        admin_refunds_path(@refund),
        success: response.message
      )
    else
      redirect_to(
        new_admin_refund_path(payment_id: @refund.payment_id),
        error: response.message
      )
    end
  end

  def show
    @stripe_refund = Stripe::Refund.retrieve(@refund.stripe_refund_id)
  end

  def edit
  end

  def update
  end

  private

  def set_refund
    @refund = Refund.find(params[:id]).decorate
  end

  def refund_params
    params.require(:refund).permit!
  end

  def request_refund
    @refund = Refund.new(refund_params)

    RefundPaymentRequest.new(
      refund: @refund,
      payment: @refund.payment
    ).perform
  end
end
