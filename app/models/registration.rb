class Registration < ApplicationRecord
  belongs_to :race
  has_one :event, through: :race
  has_one :location, through: :event
end
