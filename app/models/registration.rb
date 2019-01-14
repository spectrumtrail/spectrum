class Registration < ApplicationRecord
  belongs_to :race
  has_one :event, through: :race
end
