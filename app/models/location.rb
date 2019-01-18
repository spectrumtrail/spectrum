class Location < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events
  has_many :races, through: :events
end
