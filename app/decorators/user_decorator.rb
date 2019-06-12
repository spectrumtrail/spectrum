class UserDecorator < ApplicationDecorator
  def default_avatar_url
    if avatar.attached?
      helpers.url_for(cover_photo)
    else
      helpers.asset_path("profile-background")
    end
  end
end
