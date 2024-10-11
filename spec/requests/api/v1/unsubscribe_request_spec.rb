require 'rails_helper'

RSpec.describe "PATCH /api/v1/unsubscribe", type: :request do
  describe 'happy path' do
    it 'creates a subscription and returns the subscription information' do
      customer1 = Customer.create!(first_name: 'Billy', last_name: 'Johnson', email: 'billy@example.com', address: '123 Maple Street, Billyland, UT')
      tea = Tea.create!(title: 'Earl Grey', description: 'A fragrant black tea flavored with bergamot.', temperature: 200, brew_time: 4)
      subscription = Subscription.create!(customer: customer1, tea: tea, title: 'Subscription for Earl Grey tea.', price: 10.00, status: 'active', frequency: 'monthly')

      expect(subscription.status).to eq("active")

      patch "/api/v1/unsubscribe", params: { subscription: subscription.id }

      expect(response).to have_http_status(:success)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:data)
      expect(payload[:data]).to have_key(:id)
      expect(payload[:data][:id]).to be_a(String)
      expect(payload[:data]).to have_key(:type)
      expect(payload[:data][:type]).to eq("subscription")
      expect(payload[:data]).to have_key(:attributes)

      expect(payload[:data][:attributes]).to have_key(:title)
      expect(payload[:data][:attributes][:title]).to eq("Subscription for Earl Grey tea.")
      expect(payload[:data][:attributes]).to have_key(:price)
      expect(payload[:data][:attributes][:price]).to eq("10.0")
      expect(payload[:data][:attributes]).to have_key(:status)
      expect(payload[:data][:attributes][:status]).to eq("cancelled") # CHANGE OF STATUS HERE
      expect(payload[:data][:attributes]).to have_key(:frequency)
      expect(payload[:data][:attributes][:frequency]).to eq("monthly")

      expect(payload[:data][:attributes]).to have_key(:tea_information)
      expect(payload[:data][:attributes][:tea_information]).to have_key(:name)
      expect(payload[:data][:attributes][:tea_information][:name]).to eq("Earl Grey")
      expect(payload[:data][:attributes][:tea_information]).to have_key(:description)
      expect(payload[:data][:attributes][:tea_information][:description]).to eq("A fragrant black tea flavored with bergamot.")
      expect(payload[:data][:attributes][:tea_information]).to have_key(:temperature)
      expect(payload[:data][:attributes][:tea_information][:temperature]).to eq(200.0)
      expect(payload[:data][:attributes][:tea_information]).to have_key(:brew_time)
      expect(payload[:data][:attributes][:tea_information][:brew_time]).to eq(4.0)

      expect(payload[:data][:attributes]).to have_key(:customer_information)
      expect(payload[:data][:attributes][:customer_information]).to have_key(:first_name)
      expect(payload[:data][:attributes][:customer_information][:first_name]).to eq("Billy")
      expect(payload[:data][:attributes][:customer_information]).to have_key(:last_name)
      expect(payload[:data][:attributes][:customer_information][:last_name]).to eq("Johnson")
      expect(payload[:data][:attributes][:customer_information]).to have_key(:email)
      expect(payload[:data][:attributes][:customer_information][:email]).to eq("billy@example.com")
      expect(payload[:data][:attributes][:customer_information]).to have_key(:address)
      expect(payload[:data][:attributes][:customer_information][:address]).to eq("123 Maple Street, Billyland, UT")
    end
  end
  
  describe 'sad path' do
    it 'cannot cancel a subscription if a subscription id is not provided' do
      customer1 = Customer.create!(first_name: 'Billy', last_name: 'Johnson', email: 'billy@example.com', address: '123 Maple Street, Billyland, UT')
      tea = Tea.create!(title: 'Earl Grey', description: 'A fragrant black tea flavored with bergamot.', temperature: 200.0, brew_time: 4.0)
      subscription = Subscription.create!(customer: customer1, tea: tea, title: 'Subscription for Earl Grey tea.', price: 10.0, status: 'active', frequency: 'monthly')

      patch "/api/v1/unsubscribe", params: { id: nil }

      expect(response).to have_http_status(:not_found)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:error)
      expect(payload[:error]).to eq("Attempt to unsubscribe failed, try entering a valid subscription id")
    end
  end
end
