class Admin::AttachmentsController < Admin::BaseController
  def index
    @attachments = fetch_attachments
  end

  private

  def fetch_attachments
    ActiveStorage::Attachment.includes(:blob).
                              where.not(record_type: 'HomePageImage').
                              order('active_storage_blobs.byte_size DESC').
                              page(params[:page]).
                              per(20)
  end
end
