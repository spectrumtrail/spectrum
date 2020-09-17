class Race < ApplicationRecord
  extend FriendlyId
  friendly_id :generate_slug, use: :slugged

  belongs_to :event
  has_one :location, through: :event
  has_many :participants

  has_one_attached :course_map
  has_one_attached :elevation_profile
  has_one_attached :briefing_document

  validates :name, presence: true
  validates :event, presence: true
  validates :starts_at, presence: true

  scope :active, -> { where(is_active: true) }
  scope :by_starts_at, -> { order(starts_at: :asc) }
  scope :upcoming, -> { where("starts_at > NOW()") }
  scope :past, -> { where("starts_at < NOW()") }
  scope :archived, -> { where.not(archived_at: nil) }
  scope :not_archived, -> { where(archived_at: nil) }

  delegate :time_zone, to: :event

  def archived?
    archived_at.present?
  end

  def name_with_event
    "#{event.name} #{name}"
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

  def paid_participants_count
    participants.with_payment.size
  end

  def is_full?
    participants.for_start_list >= participants_cap
  end

  def is_registerable?(time)
    return false unless event.registration_open?(time)
    return false unless is_active?
    return false if archived?
    return false if is_full?
    true
  end
end
