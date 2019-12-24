class TeamMember < ApplicationRecord
  validates :name, :bio_html, presence: true

  has_one_attached :profile_image
  has_one_attached :cover_image

  def prev
    TeamMember.where("id < ?", id).order("id DESC").first || TeamMember.last
  end

  def next
    TeamMember.where("id > ?", id).order("id ASC").first || TeamMember.first
  end

  extend FriendlyId
  friendly_id :name, use: :slugged
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  def social?
    instagram_link.present? || strava_link.present?
  end
end
