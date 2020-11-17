class VolunteerPosition < ApplicationRecord
  belongs_to :event
  has_many :volunteers
end
