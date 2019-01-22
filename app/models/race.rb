class Race < ApplicationRecord
  belongs_to :event
  has_one :location, through: :event
  has_many :registrations

  has_one_attached :course_map
  has_one_attached :elevation_profile
  has_one_attached :briefing_document

  validates :name, presence: true

  scope :active, -> { where(is_active: true) }

  def is_open?
    true
  end

  def name_with_event
    "#{event.name} #{name}"
  end
end
