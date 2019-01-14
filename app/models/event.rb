class Event < ApplicationRecord
  has_many :races

  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
end
