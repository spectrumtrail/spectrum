class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :location
  has_many :races, dependent: :destroy
  has_many :regisratrations, through: :races

  # attachments
  has_one_attached :logo
  has_one_attached :cover_photo
  has_many_attached :promo_photos

  validates :name, presence: true
  validates :starts_at, presence: true
end
