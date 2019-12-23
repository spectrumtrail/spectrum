class UserDecorator < ApplicationDecorator
  def default_avatar_url
    if avatar.attached?
      helpers.url_for(avatar)
    else
      helpers.asset_path("logo-no-text")
    end
  end
end
