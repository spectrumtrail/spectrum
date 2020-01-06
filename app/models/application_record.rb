class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def any_attached?
    ActiveStorage::Attachment.where(
      record_type: model_name.to_s,
      record_id: id
    ).any?
  end
end
