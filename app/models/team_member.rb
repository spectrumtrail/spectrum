class TeamMember < ApplicationRecord
  validates :name, :bio_html, presence: true

  has_one_attached :profile_image
  has_one_attached :cover_image
end
