class SettingsController < ApplicationController
  def index
  end

  def set_default_category
    current_user.update(default_category_id: params[:default_category_id])
    redirect_via_turbolinks_to settings_path
  end

  def import_csv
    if params[:payments]
      csv_text = params[:payments].read
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |item|
        current_user.payments.create!(
          date: Date.strptime(item['Date'], '%d/%m/%y'),
          amount: item['Value'].to_f,
          category: current_user.default_category
        )
      end
    end
    redirect_to settings_path
  end
end
