class Admin::PaymentsController < Admin::BaseController
  before_action :set_payment, only: [:edit, :update, :destroy, :show]

  def index
    @payments = Payment.includes(:registration).
                        order(created_at: :desc).
                        page(params[:page]).
                        decorate
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
