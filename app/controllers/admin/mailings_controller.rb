class Admin::MailingsController < Admin::BaseController
  def index
    @mailings = Ahoy::Message.order(sent_at: :desc).page(params[:page])
  end

  def show
    @mailing = Ahoy::Message.find(params[:id])
  end
end
