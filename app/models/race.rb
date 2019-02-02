class Race < ApplicationRecord
  extend FriendlyId
  friendly_id :generate_slug, use: :slugged

  belongs_to :event
  has_one :location, through: :event
  has_many :registrations, through: :event
  has_many :participants

  has_one_attached :course_map
  has_one_attached :elevation_profile
  has_one_attached :briefing_document

  validates :name, presence: true
  validates :event, presence: true
  validates :starts_at, presence: true

  scope :active, -> { where(is_active: true) }

  delegate :time_zone, to: :event

  def is_open?
    true
  end

  def name_with_event
    "#{event.name} #{name}"
  end

  def name_with_event_and_price
    "#{name_with_event} - ( $#{price_in_cents / 100} )"
  end

  def generate_slug
    "#{starts_at.year} #{event.name} #{name}".parameterize
  end

  def should_generate_new_friendly_id?
    return true if slug.blank?
    return true if name_changed?
    return true if event_id_changed?
    return true if starts_at_changed?
    false
  end
end
