class SettingsController < ApplicationController
  def index
  end

  def set_default_category
    current_user.update(default_category_id: params[:default_category_id])
    redirect_via_turbolinks_to settings_path
  end
end
