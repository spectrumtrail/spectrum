class Location < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events
  has_many :races, through: :events

  validates :name, presence: true
  validates :description, presence: true
  validates :short_description, presence: true
  validates :external_website_link, presence: true

  scope :active, -> { where(is_active: true) }
end
