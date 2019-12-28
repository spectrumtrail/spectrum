class StaticPagesController < ApplicationController
  layout :resolve_layout

  def about
  end

  def danger
    render layout: nil
  end

  def home
    @events = Event.includes(:location, :cover_photo_attachment).
                    is_active.
                    by_starts_at.
                    decorate


    @home_page_images = HomePageImage.includes(:image_attachment).
                                      not_hidden.
                                      rank(:display_order)

    @sponsors = Sponsor.includes(:logo_attachment).order(:name).decorate
  end

  def privacy
  end

  def store
    redirect_to("https://store.spectrumtrailracing.com")
  end

  def results_path
  end

  def terms
  end

  def no_script_warning
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
