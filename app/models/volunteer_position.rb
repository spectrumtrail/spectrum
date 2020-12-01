class VolunteerPosition < ApplicationRecord
  belongs_to :event
  has_many :volunteers

  validates :event_id, presence: true
  validates :name, presence: true
end
