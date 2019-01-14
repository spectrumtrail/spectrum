class Location < ApplicationRecord
  has_many :events
  has_many :races, through: :events
end
