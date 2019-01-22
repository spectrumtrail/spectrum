class Registration < ApplicationRecord
  belongs_to :race, counter_cache: true
  has_one :event, through: :race
  has_one :location, through: :event

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
