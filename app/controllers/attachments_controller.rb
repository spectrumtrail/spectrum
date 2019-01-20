class AttachmentsController < ActionController::Base
  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge

    respond_to do |format|
      format.js {
        flash[:success] = "Attachment successfully removed."
      }
    end
  end
end
