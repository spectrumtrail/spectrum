class StaticPagesController < ApplicationController
  layout :resolve_layout

  def about
  end

  def danger
    render layout: nil
  end

  def home
    @events = Event.is_active.order(:name).decorate
    @sponsors = Sponsor.order(:name).decorate
    @promo_photos = []
  end

  def privacy
  end

  def terms
  end

  private

  def resolve_layout
    if action_name == "danger"
      nil
    else
      "application"
    end
  end
end
