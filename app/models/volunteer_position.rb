class VolunteerPosition < ApplicationRecord
  belongs_to :event
  has_many :volunteers

  validates :name, presence: true, uniqueness: { scope: :event_id }
end
