class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  expose(:payment, attributes: :payment_params)
  expose(:payments) { current_user.payments.order(date: :desc).includes(:category).page(params[:page]).per(50) }

  def index
  end

  def create
    payment.user_id = current_user.id
    if payment.save
      redirect_via_turbolinks_to payments_path
    end
  end

  def update
    if payment.save
      redirect_via_turbolinks_to payments_path
    else
      render :edit
    end
  end

  def destroy
    payment.destroy
    redirect_via_turbolinks_to payments_path
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :date, :category_id, :image, :notes)
  end
end
