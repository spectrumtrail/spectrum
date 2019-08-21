class Sponsor < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name,
    :promo_html,
    :promo_link,
    :short_description,
    presence: true

  # attachments
  has_one_attached :logo
  has_one_attached :cover_photo
  has_many_attached :promo_photos

  scope :with_attachments, -> { includes(logo_attachment: :blob, cover_photo_attachment: :blob, promo_photos_attachments: :blob) }
end
