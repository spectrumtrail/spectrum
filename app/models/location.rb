class Location < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  has_many :events
  has_many :races, through: :events
  has_one_attached :cover_photo
  has_many_attached :promo_photos

  validates :name, presence: true, length: { minimum: 5 }
  validates :description_html, presence: true, length: { minimum: 5 }
  validates :short_description, presence: true, length: { minimum: 5 }
  validates :external_website_link, presence: true, length: { minimum: 5 }

  scope :active, -> { where(is_active: true) }
end
