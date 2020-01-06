class Admin::AttachmentsController < Admin::BaseController
  def index
    @attachments = ActiveStorage::Attachment.includes(:blob).
                                             page(params[:page]).
                                             per(20)
  end
end
