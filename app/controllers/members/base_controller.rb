class Members::BaseController < ApplicationController
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  layout -> (controller) { controller.request.xhr? ? false : "members/base" }
end
