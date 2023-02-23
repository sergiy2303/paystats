require 'rails_helper'

RSpec.describe Api::Admin::PaymentsController, type: :controller do
  include AuthHelper
  let(:public_category) { create(:category) }
  let(:user) { create(:user, default_category_id: public_category.id) }
  let(:payment) { create(:payment, user: user, category: public_category, amount: 9) }

  let(:user_2) { create(:user, default_category_id: public_category.id) }
  let(:category_2) { create(:category, user: user_2) }
  let(:payment_2) { create(:payment, user: user_2, category: category_2) }

  describe 'get #index' do
    context 'success' do
      before(:each) { http_login }
      it 'renders all payments for all users' do
        payment
        payment_2
        get :index
        body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(body.first['amount']).to eq('9.0')
      end
    end

    context 'failure' do
      it 'returns 401' do
        get :index

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'get #show' do
    context 'success' do
      before(:each) { http_login }
      it 'renders all payments for all users' do
        get :show, { id: payment_2.id }, as: :json

        body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(body['amount']).to eq('10.0')
      end
    end

    context 'failure' do
      it 'returns 401' do
        get :show, { id: payment_2.id }, as: :json

        expect(response.status).to eq(401)
      end
    end
  end
end
