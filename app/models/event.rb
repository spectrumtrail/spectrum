class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :location
  has_many :races
  has_many :regisratrations, through: :races

  validates :name, presence: true
  validates :starts_at, presence: true
end
