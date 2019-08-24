class TeamMemberDecorator < ApplicationDecorator
  def row_thumbnail
    if team_member.profile_image.attached?
      helpers.url_for(team_member.profile_image.variant(resize: "100x100"))
    else
      helpers.asset_path("logo-no-text")
    end
  end
end
