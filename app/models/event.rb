class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  belongs_to :location
  has_many :races, dependent: :destroy
  has_many :registrations, counter_cache: true
  has_many :participants, through: :registrations

  # attachments
  has_one_attached :logo
  has_one_attached :cover_photo
  has_many_attached :promo_photos

  validates :name, presence: true
  validates :starts_at, presence: true
end
