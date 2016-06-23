module StatsHelper
  def last_month
    @last_month ||= calculate_total_amount(find_payments_for_month(Date.today.prev_month, Date.today))
  end

  def previous_month
    @prev_month ||= calculate_total_amount(find_payments_for_month(Date.today.prev_month(2), Date.today.prev_month))
  end

  def average_per_day
    last_month / (Date.today - Date.today.prev_month).to_i
  end

  def average_per_day_last
    previous_month / (Date.today.prev_month - Date.today.prev_month(2)).to_i
  end

  def all_time
    @all_time ||= calculate_total_amount(payments)
  end

  def average_per_day_all
    all_time / (payments.maximum('date') - payments.minimum('date'))
  end

  def find_payments_for_month(start_date, end_date)
    payments.where(
      "date > :start_date AND date <= :end_date", start_date: start_date, end_date: end_date
    )
  end

  def calculate_total_amount(payments)
    payments.map(&:amount).inject(0){|sum,x| sum + x }
  end

  def payments
    @payments ||= current_user.payments
  end
end
