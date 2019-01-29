class Series < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  validates :name, presence: true

  has_one_attached :logo
  has_one_attached :cover_photo
  has_many_attached :promo_photos

  scope :is_active, -> { where(is_active: true) }
end
