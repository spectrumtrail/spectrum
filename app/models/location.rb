class Location < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events
  has_many :races, through: :events
  has_one_attached :cover_photo
  has_many_attached :promo_photos

  validates :name, presence: true
  validates :description_html, presence: true
  validates :short_description, presence: true
  validates :external_website_link, presence: true

  scope :active, -> { where(is_active: true) }
end
