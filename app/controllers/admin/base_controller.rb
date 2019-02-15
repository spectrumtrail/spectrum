class Admin::BaseController < ApplicationController
  layout -> (controller) { controller.request.xhr? ? false : "admin/base" }
end
