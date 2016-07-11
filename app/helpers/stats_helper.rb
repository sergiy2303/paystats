module StatsHelper
  def current_month
    @current_month ||= calculate_total_amount(payments_for_month(Date.today))
  end

  def previous_month
    @prev_month ||= calculate_total_amount(payments_for_month(Date.today.prev_month))
  end

  def average_per_day
    current_month / (Date.today - Date.today.prev_month).to_i
  end

  def average_per_day_last
    previous_month / (Date.today.prev_month - Date.today.prev_month(2)).to_i
  end

  def all_time
    @all_time ||= calculate_total_amount(payments)
  end

  def average_per_day_all
    return 0 unless payments.present?
    all_time / (payments.maximum('date') - payments.minimum('date') + 1)
  end

  def calculate_total_amount(payments)
    payments.map(&:amount).inject(0){|sum,x| sum + x }
  end

  def payments
    @payments ||= current_user.payments
  end

  def payments_for_month(date = Date.today)
    payments.where("date >= :start_date AND date <= :end_date", start_date: start_day(date), end_date: end_day(date))
  end

  def data_for_graph(date = Date.today)
    @graph = Hash[(start_day(date)..end_day(date)).collect { |v| [ v, 0 ] }]
    payments_for_month(date).each do |payment|
      @graph.has_key?(payment.date) ? @graph[payment.date] += payment.amount : @graph[payment.date] = payment.amount
    end
    @graph
  end

  def mountly_limit
    data_for_graph.each do |key, value|
      data_for_graph[]
    end
  end

  def start_day(date = Date.today)
    Date.new(date.year, date.month, 1)
  end

  def end_day(date = Date.today)
    Date.new(date.year, date.month, -1)
  end
end
