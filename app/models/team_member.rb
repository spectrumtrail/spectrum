class TeamMember < ApplicationRecord
  validates :name, :bio_html, presence: true

  has_one_attached :profile_image
end
