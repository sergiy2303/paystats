module PaymentsHelper

  def form_params
    params = { date: {}, category: {} }
    if action_name == 'new'
      params[:date] = { value: last_payment&.date || Date.today }
      params[:category] = { selected: default_category.id }
    end
    params
  end

  def default_category
    @category ||= current_user.default_category
  end

  def last_payment
    @last_payment ||= current_user.payments.order(created_at: :desc).first
  end
end
