class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  belongs_to :location
  has_many :races, dependent: :destroy
  has_many :registrations, counter_cache: true
  has_many :participants

  # attachments
  has_one_attached :logo
  has_one_attached :cover_photo
  has_many_attached :promo_photos

  scope :with_attachments, -> { includes(logo_attachment: :blob, cover_photo_attachment: :blob, promo_photos_attachments: :blob) }

  validates :name, presence: true
  validates :short_description, presence: true
  validates :starts_at, presence: true
  validates :time_zone, presence: true
  validates :registration_opens_at, presence: true
  validates :registration_closes_at, presence: true

  scope :is_active, -> { where(is_active: true) }
  scope :by_starts_at, -> { order(starts_at: :asc) }

  def registration_open?(time)
    return false unless is_active?
    return false if registration_opens_at > time # before window
    return false if registration_closes_at < time # after window
    return true
  end

  def sold_out?
    races.each do |race|
      return false if race.is_full? == false
    end

    true
  end
end
