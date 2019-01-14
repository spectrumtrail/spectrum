class Race < ApplicationRecord
  belongs_to :event
  has_one :location, through: :event
  has_many :registrations

  validates :name, presence: true
end
