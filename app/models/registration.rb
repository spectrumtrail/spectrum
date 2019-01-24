class Registration < ApplicationRecord
  belongs_to :race
  belongs_to :event
  has_one :location, through: :event

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end
