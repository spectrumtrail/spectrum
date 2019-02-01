class StaticPagesController < ApplicationController
  def home
    @events = Event.is_active.order(:name)
  end

  def terms
  end

  def privacy
  end

  def about
  end

  def team
  end
end
