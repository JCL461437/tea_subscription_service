require 'rails_helper'

RSpec.describe "GET /api/v1/subscriptions", type: :request do
  describe 'happy path' do
    it 'returns the customer subscriptions information' do
      customer = Customer.create!(first_name: 'Billy', last_name: 'Johnson', email: 'billy@example.com', address: '123 Maple Street, Billyland, UT')
      tea1 = Tea.create!(title: 'Earl Grey', description: 'A fragrant black tea flavored with bergamot.', temperature: 200.0, brew_time: 4.0)
      tea2 = Tea.create!(title: 'Chamomile', description: 'A calming herbal tea with chamomile flowers.', temperature: 180.0, brew_time: 5.0)

      subscription1 = Subscription.create!(customer: customer, tea: tea1, title: 'Earl Grey Subscription', price: 10.99, status: 'active', frequency: 'monthly')
      subscription2 = Subscription.create!(customer: customer, tea: tea2, title: 'Chamomile Subscription', price: 12.5, status: 'cancelled', frequency: 'weekly')

      get "/api/v1/subscriptions?customer=billy@example.com"

      expect(response).to have_http_status(:success)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:data)
      expect(payload[:data]).to have_key(:id)
      expect(payload[:data][:id]).to be_a(String)
      expect(payload[:data]).to have_key(:type)
      expect(payload[:data][:type]).to eq("customer_subscriptions")
      expect(payload[:data]).to have_key(:attributes)

      expect(payload[:data][:attributes]).to have_key(:first_name)
      expect(payload[:data][:attributes][:first_name]).to eq("Billy")
      expect(payload[:data][:attributes]).to have_key(:last_name)
      expect(payload[:data][:attributes][:last_name]).to eq("Johnson")
      expect(payload[:data][:attributes]).to have_key(:email)
      expect(payload[:data][:attributes][:email]).to eq("billy@example.com")
      expect(payload[:data][:attributes]).to have_key(:address)
      expect(payload[:data][:attributes][:address]).to eq("123 Maple Street, Billyland, UT")
      
      expect(payload[:data][:attributes]).to have_key(:subscriptions)
      expect(payload[:data][:attributes][:subscriptions]).to be_an(Array)
      expect(payload[:data][:attributes][:subscriptions].length).to eq(2)

      subscription1_data = payload[:data][:attributes][:subscriptions].find { |sub| sub[:title] == "Earl Grey Subscription" }
      expect(subscription1_data).to have_key(:title)
      expect(subscription1_data[:title]).to eq("Earl Grey Subscription")
      expect(subscription1_data).to have_key(:price)
      expect(subscription1_data[:price]).to eq("10.99")
      expect(subscription1_data).to have_key(:status)
      expect(subscription1_data[:status]).to eq("active")
      expect(subscription1_data).to have_key(:frequency)
      expect(subscription1_data[:frequency]).to eq("monthly")

      subscription2_data = payload[:data][:attributes][:subscriptions].find { |sub| sub[:title] == "Chamomile Subscription" }
      expect(subscription2_data).to have_key(:title)
      expect(subscription2_data[:title]).to eq("Chamomile Subscription")
      expect(subscription2_data).to have_key(:price)
      expect(subscription2_data[:price]).to eq("12.5")
      expect(subscription2_data).to have_key(:status)
      expect(subscription2_data[:status]).to eq("cancelled")
      expect(subscription2_data).to have_key(:frequency)
      expect(subscription2_data[:frequency]).to eq("weekly")
    end
  end

  describe 'sad path' do
    it 'returns an error if no customer email is not provided' do
      get "/api/v1/subscriptions"

      expect(response).to have_http_status(:bad_request)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:error)
      expect(payload[:error]).to eq("Request for customer subscriptions failed, enter a customer email")
    end

    it 'returns an error if the customer email does not exist' do
      get "/api/v1/subscriptions?customer=nonexistent@example.com"

      expect(response).to have_http_status(:not_found)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:error)
      expect(payload[:error]).to eq("Request for customer subscriptions failed, that email does not exist")
    end
  end
end
