class Api::Admin::PaymentsController < Api::Admin::BaseController
  def index
    render json: Payment.all
  end

  def show
    render json: Payment.find(params[:id])
  end
end
