require 'csv'

class SettingsController < ApplicationController
  def index
  end

  def set_default_category
    current_user.update(default_category_id: params[:default_category_id])
    redirect_via_turbolinks_to settings_path
  end

  def import_csv
    if params[:payments].present?
      csv_text = params[:payments].read
      csv = CSV.parse(csv_text, :headers => true)
      default_category = current_user.default_category
      csv.each do |item|
        category = Category.all_categories_for(current_user).find_by(name: item['Category']) if item['Category']
        current_user.payments.create!(
          date: Date.strptime(item['Date'], '%d/%m/%y'),
          amount: item['Value'].to_f,
          category: category || default_category,
          notes: item['Notes']
        )
      end
      flash[:success] = 'Your payments has been import success'
    end
  rescue Exception
    flash[:danger] = 'You entered file in invalid format'
  ensure
    redirect_to settings_path
  end

  def export_csv
    content = CSV.generate do |csv|
      csv << %w{Date Value Category Notes}
      current_user.payments.order(date: :desc).includes(:category).each do |payment|
        csv << [
          payment.date.strftime('%d/%m/%y'),
          payment.amount,
          payment&.category&.name&.capitalize,
          payment.notes,
        ]
      end
    end

    send_data content,
      type: 'text',
      disposition: "attachment; filename=payments.csv"
  end
end
