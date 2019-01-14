class Event < ApplicationRecord
  belongs_to :location
  has_many :races
  has_many :regisratrations, through: :races

  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
end
