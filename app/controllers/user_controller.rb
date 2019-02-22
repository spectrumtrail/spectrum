class UserController < ApplicationController
  def show
    @sponsor = Sponsor.all.sample
  end
end
