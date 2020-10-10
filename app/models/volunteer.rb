class Volunteer < ApplicationRecord
  belongs_to :event

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :position, presence: true
  validates :time, presence: true
end
