class Api::Admin::BaseController < ApplicationController
  skip_before_action :authenticate_user!
  http_basic_authenticate_with name: 'admin', password: ENV['ADMIN_PASSWORD'] || 'D21tD_##21afhd'
end
