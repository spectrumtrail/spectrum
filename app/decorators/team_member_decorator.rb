class TeamMemberDecorator < ApplicationDecorator
  def row_thumbnail
    if team_member.profile_image.attached?
      helpers.url_for(team_member.profile_image.variant(resize: "100x100"))
    else
      helpers.asset_path("logo-no-text")
    end
  end

  def default_cover_photo_url
    if cover_image.attached?
      helpers.url_for(cover_image)
    else
      helpers.asset_path("logo-no-text")
    end
  end
end
