class Volunteer < ApplicationRecord
  belongs_to :event
  belongs_to :volunteer_position

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: { scope: :event }
  validates :time, presence: true
end
