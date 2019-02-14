class Admin::BaseController < ApplicationController
  layout -> (controller) { controller.request.xhr? ? false : 'admin' }
  before_action :require_admin!

end
